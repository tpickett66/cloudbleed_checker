require_relative 'browser'
module CloudbleedChecker
  class Chrome < Browser
    TIMESTAMP_MAGIC_NUMBER = 11644473600 # No idea where this came from, should probaby figure that out from the chrome source
    TIMESTAMP_DIVISOR = 1_000_000 # convert usec to seconds

    self.history_db_glob = "~/Library/Application Support/Google/Chrome/*/History"

    def extract_domains
      with_databases do |db|
        ds = db[:urls].
          select(:url, :last_visit_time).
          where("(last_visit_time/?) - ? >= ?", TIMESTAMP_DIVISOR, TIMESTAMP_MAGIC_NUMBER, CloudbleedChecker::INITIAL_VULNERABILITY_RELEASED.to_i).
          order(:last_visit_time)
        extract_hosts(ds, :url)
      end
    end
  end
end
