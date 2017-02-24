require_relative 'browser'

module CloudbleedChecker
  class Firefox < Browser
    self.history_db_glob = '~/Library/Application Support/Firefox/Profiles/*/places.sqlite'

    def extract_domains
      with_databases do |db|
        ds = db[:moz_places].
          select('DISTINCT(url), last_visit_date').
          where('last_visit_date  >= ?', CloudbleedChecker::INITIAL_VULNERABILITY_RELEASED.to_i).
          order(:last_visit_date)
        extract_hosts(ds, :url)
      end
    end
  end
end
