AdMob API [![Build Status](https://travis-ci.org/mako2x/admob-api.png?branch=master)](https://travis-ci.org/mako2x/admob-api)
===

A Ruby interface to the Admob API

Installation
---

Add this line to your application's Gemfile:

    gem 'admob-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install admob-api

Usage
---

```ruby
require 'admob-api'

# Authentication
admob = AdMobApi.new do |c|
  c.client_key = 'yourclientkey'
  c.email      = 'foobar@mail.com'
  c.password   = 'yourpassword'
end

# Site
sites = admob.sites
p sites.first.id
p sites.first.name
p sites.first.description
p sites.first.url

# Stats
stats = admob.stats(sites.first.id)
stats = admob.stats(sites.first.id, :yesterday)
stats = admob.stats(sites.map(&:id), :last_7days)
stats = admob.stats(sites.map(&:id), :last_30days)
stats = admob.stats(sites.map(&:id), :previous_month)
stats = admob.stats(sites.map(&:id), :previous_quarter)
stats = admob.stats(sites.map(&:id), :quarter_to_date)
stats = admob.stats(sites.map(&:id), Date.new(2013, 1, 1)..Date.new(2013, 3, 31), {
  :order_by => :impressions,
  :order    => :asc
})
p stats.clicks
p stats.requests
p stats.revenue
p stats.impressions
p stats.ctr
p stats.ecpm
p stats.fill_rate
p stats.date
p stats.cpc_impressions
p stats.cpc_revenue
p stats.cpm_impressions
p stats.cpm_revenue
p stats.exchange_downloads
p stats.exchange_impressions
p stats.housead_clicks
p stats.housead_ctr
p stats.housead_fill_rate
p stats.housead_impressions
p stats.housead_requests
p stats.interstitial_impressions
p stats.interstitial_requests
p stats.overall_fill_rate
p stats.overall_requests

# Logout
admob.logout

```

Contributing
---

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
