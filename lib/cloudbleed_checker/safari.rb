require_relative 'browser'

module CloudbleedChecker
  class Safari < Browser
    TIMESTAMP_OFFSET = 978307200

    self.history_db_path = '~/Library/Safari/History.db'

    def extract_domains
      with_database do |db|
        ds = db[:history_items].
          select('DISTINCT(url), visit_time ').
          join(:history_visits).
          where('visit_time + ? >= ?', TIMESTAMP_OFFSET, CloudbleedChecker::INITIAL_VULNERABILITY_RELEASED.to_i).
          order(:visit_time)
        extract_hosts(ds, :url)
      end
    end
  end
end
