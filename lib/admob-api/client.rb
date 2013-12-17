require 'httpclient'
require 'json'
require 'admob-api/ad'
require 'admob-api/ad_group'
require 'admob-api/campaign'
require 'admob-api/site'
require 'admob-api/stats'
require 'admob-api/validator'
require 'admob-api/date_range'

class AdMobApi
  class Client
    attr_writer :client_key, :email, :password

    private
    def get(path, params = {})
      request(:get, path, params)
    end

    def post(path, params = {})
      request(:post, path, params)
    end

    include AdMobApi::Validator
    def request(method, path, params = {})
      params[:client_key] = @client_key
      params[:token]      = @token
      res     = @agent.request(method, AdMobApi::URL + path, params)
      content = JSON.parse(res.content)
      validate(content)
      content['data']
    end

    public
    def initialize(&block)
      block.call(self)

      @agent = HTTPClient.new
      res = post('/v2/auth/login', {
        :email    => @email,
        :password => @password
      })
      @token = res['token']
    end

    def logout
      post('/v2/auth/logout')
      @client_key, @email, @password, @token = nil
    end

    def sites(params = {})
      res    = get('/v2/site/search', params)
      res.map {|s| AdMobApi::Site.new(s) }
    end
    
    def ads(params = {})
      res = get('/v2/ad/search', params)
      res.map {|s| AdMobApi::Ad.new(s) }
    end
    
    def ad_groups(params = {})
      res = get('/v2/ad_group/search', params)
      res.map {|s| AdMobApi::AdGroup.new(s) }
    end
    
    def campaigns(params = {})
      res = get('/v2/campaign/search', params)
      res.map {|s| AdMobApi::Campaign.new(s) }
    end

    def stats(ids, type, date_range = :today, opt = {})
      if date_range.is_a?(Symbol)
        date_range = AdMobApi::DateRange.send(date_range)
      end
      
      id_key = ids.is_a?(Array) ? "#{type}_id[]" : "#{type}_id"
      params = {
        id_key => ids,
        :start_date => date_range.begin,
        :end_date   => date_range.end
      }
      params[:object_dimention] = opt[:object_dimention] unless opt[:object_dimention].nil?
      params[:time_dimention]   = opt[:time_dimention] unless opt[:time_dimention].nil?
      unless opt[:order_by].nil?
        params["order_by[#{opt[:order_by]}]"] = opt[:order] || :desc       
      end
      res = get("/v2/#{type}/stats", params)
      AdMobApi::Stats.new(res.first)
    end
  end
end
