require File.dirname(__FILE__) + '/spec_helper.rb'

describe AdMobApi::DateRange do
  before do
    allow(Date).to receive(:today).and_return(Date.new(2013, 7, 16))
  end

  describe '.today' do
    it 'returns range of today' do
      expected = Date.new(2013, 7, 16)..Date.new(2013, 7, 16)
      expect(AdMobApi::DateRange.today).to eq expected
    end
  end

  describe '.yesterday' do
    it 'returns range of yesterday' do
      expected = Date.new(2013, 7, 15)..Date.new(2013, 7, 15)
      expect(AdMobApi::DateRange.yesterday).to eq expected
    end
  end

  describe '.last_7days' do
    it 'returns range of last 7 days' do
      expected = Date.new(2013, 7, 9)..Date.new(2013, 7, 16)
      expect(AdMobApi::DateRange.last_7days).to eq expected
    end
  end

  describe '.previous_month' do
    it 'returns range of previous month' do
      expected = Date.new(2013, 6, 1)..Date.new(2013, 6, 30)
      expect(AdMobApi::DateRange.previous_month).to eq expected
    end
  end

  describe '.previous_quarter' do
    it 'returns range of previous quarter' do
      expected = Date.new(2013, 4, 1)..Date.new(2013, 6, 30)
      expect(AdMobApi::DateRange.previous_quarter).to eq expected
    end
  end

  describe '.month_to_date' do
    it 'returns range of month to date' do
      expected = Date.new(2013, 7, 1)..Date.new(2013, 7, 16)
      expect(AdMobApi::DateRange.month_to_date).to eq expected
    end
  end

  describe '.quarter_to_date' do
    it 'returns range of quarter to date' do
      expected = Date.new(2013, 7, 1)..Date.new(2013, 7, 16)
      expect(AdMobApi::DateRange.quarter_to_date).to eq expected
    end
  end

  describe '.year_to_date' do
    it 'returns range of year to date' do
      expected = Date.new(2013, 1, 1)..Date.new(2013, 7, 16)
      expect(AdMobApi::DateRange.year_to_date).to eq expected
    end
  end
end
