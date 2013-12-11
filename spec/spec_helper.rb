$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'admob-api'
require 'bundler/setup'
require 'webmock/rspec'

def stub_get(path)
  WebMock.stub_request(:get, AdMobApi::URL + path)
end

def stub_post(path)
  WebMock.stub_request(:post, AdMobApi::URL + path)
end

def fixture(file)
  File.new("#{File.dirname(__FILE__)}/fixtures/#{file}")
end
