require 'fileutils'
require 'set'
require 'sequel'
require 'sqlite3'
require 'uri'

module CloudbleedChecker
  class Browser
    class << self
      attr_accessor :history_db_path
      attr_accessor :history_db_glob

      def extract_domains(tmpdir)
        new(tmpdir).extract_domains
      end
    end

    def initialize(tmpdir)
      @tmpdir = tmpdir
      @hosts = Set.new
    end

    def extract_hosts(dataset, url_key)
      dataset.paged_each do |row|
        host = extract_host(row, url_key)
        @hosts << host if host
      end
      @hosts
    end

    def extract_host(row, url_key)
      url = row[url_key]
      return if url.nil?
      URI.parse(url).host
    rescue URI::InvalidURIError => ex
      puts "unable to parse url: '#{row[url_key]}', skipping"
    end

    def history_db_path
      self.class.history_db_path
    end

    def history_db_glob
      self.class.history_db_glob
    end

    def with_database(db_path = history_db_path)
      dest_path = @tmpdir.join(self.class.name)
      FileUtils.cp(File.expand_path(db_path), dest_path)
      db = Sequel.sqlite(dest_path.to_s)
      yield db
    ensure
      db.disconnect if db
    end

    def with_databases(&block)
      full_glob = File.expand_path(self.history_db_glob)
      Dir.glob(full_glob).each do |db_path|
        with_database(db_path, &block)
      end
      @hosts
    end
  end
end
