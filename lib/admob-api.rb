require 'admob-api/version'
require 'admob-api/client'

class AdMobApi
  URL = 'https://api.admob.com'

  def self.new(&block)
    AdMobApi::Client.new(&block)
  end
end
