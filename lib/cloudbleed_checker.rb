require 'cloudbleed_checker/chrome'
require 'cloudbleed_checker/cli'
require 'cloudbleed_checker/firefox'
require 'cloudbleed_checker/safari'
require "cloudbleed_checker/version"
require 'uri'

module CloudbleedChecker
  CLOUDFLARE_SITES_URL = URI.parse('https://raw.githubusercontent.com/pirate/sites-using-cloudflare/master/sorted_unique_cf.txt')
  INITIAL_VULNERABILITY_RELEASED = Date.civil(2016, 9, 22).to_time

  def data
    DATA
  end
end
