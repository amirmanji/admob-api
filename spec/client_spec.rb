require File.dirname(__FILE__) + '/spec_helper.rb'

describe AdMobApi::Client do
  let(:client_key) { '123456789abcdefghijklmnopqrstuvw' }
  let(:admob) do
    email       = 'admob@gmail.com'
    password    = 'password'

    stub_post('/v2/auth/login')
      .with(:query => {
        :client_key => client_key,
        :email      => email,
        :password   => password,
        :token      => nil
      })
      .to_return(:body => fixture('login.json'))

    AdMobApi.new do |c|
      c.client_key = client_key
      c.email      = email
      c.password   = password
    end
  end

  describe '#sites' do
    it 'returns array of site' do
      stub_get('/v2/site/search')
        .with(:query => {
          :client_key => client_key,
          :token      => admob.instance_variable_get(:@token),
        })
        .to_return(:body => fixture('search_site.json'))

      site = admob.sites.find { |s| s.name == 'foo' }
      expect(site.id).to eq 'a11111111111111'
      expect(site.name).to eq 'foo'
      expect(site.url).to eq 'market://details?id=com.foo.bar'
      expect(site.description).to eq 'foobar'
    end
  end

  describe '#sites' do
    it 'returns site stats' do
      id         = 'a11111111111111'
      start_date = Date.new(2013, 6, 1)
      end_date   = Date.new(2013, 6, 6)
      stub_get('/v2/site/stats')
        .with(:query => {
          :client_key => client_key,
          :token      => admob.instance_variable_get(:@token),
          :site_id    => id,
          :start_date => start_date,
          :end_date   => end_date
        })
        .to_return(:body => fixture('site_stats.json'))

      stats = admob.stats(id, start_date..end_date)
      expect(stats.clicks).to be 89312
      expect(stats.revenue).to be 4483.1018
      expect(stats.ecpm).to be 1.186
      expect(stats.impressions).to be 3779956
      expect(stats.date).to eq "#{start_date}/#{end_date}"
    end
  end
end
