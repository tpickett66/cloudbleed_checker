require 'pathname'
require 'set'
require 'tmpdir'
require 'thor'
require 'net/http'
require 'zlib'

module CloudbleedChecker
  class CLI < Thor
    desc "check", "Check all supported browsers"
    def check
      Dir.mktmpdir do |tmpdir|
        puts 'Extracting history....'
        tmpdir = Pathname.new(tmpdir)
        domains = Chrome.extract_domains(tmpdir)
        domains.merge(Safari.extract_domains(tmpdir))
        domains.merge(Firefox.extract_domains(tmpdir))
        puts "Extracted #{domains.size} unique hosts from your browser histories"

        puts 'Checking sites'
        num_checked = 0
        domains_path = File.join(File.dirname(__FILE__), 'domains.gz')
        Zlib::GzipReader.open(domains_path) do |file|
          file.each_line do |domain|
            domain.chomp!
            if domains.include?(domain)
              puts "History included '#{domain}' from list"
            end
          end
        end
      end
      puts "Check complete"
    end
  end
end
