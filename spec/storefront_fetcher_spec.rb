require 'spec_helper'

describe ITunesCrawler::StorefrontFetcher do
  describe "it should download data from iTunes for" do
    it "one iTunes id" do
      storefrontFetcher = ITunesCrawler::StorefrontFetcher.new
      storefrontFetcher.on_success do |itunes_item|
        itunes_item.should be_a_kind_of( Hash )
      end
      storefrontFetcher.on_fail { |itunes_id| fail }
      storefrontFetcher.fetch( '557137623', 'us' )
    end
    
    it "multiple itunes ids" do
      storefrontFetcher = ITunesCrawler::StorefrontFetcher.new
      storefrontFetcher.on_success do |itunes_item|
        itunes_item.should be_a_kind_of( Hash )
      end
      storefrontFetcher.on_fail { |itunes_id| fail }
      storefrontFetcher.fetch( ['557137623', '284882215'], 'us' )
    end
  end
  
  describe "response should include readable values" do
    it do
      storefrontFetcher = ITunesCrawler::StorefrontFetcher.new
      storefrontFetcher.on_success do |itunes_item|
        itunes_item["kind"].should eql "software"
      end
      storefrontFetcher.on_fail { |itunes_id| fail }
      storefrontFetcher.fetch( '557137623', 'us' )
    end
  end
  
  describe "it should fail while trying to download data for invalid iTunes ID" do
    it do
      storefrontFetcher = ITunesCrawler::StorefrontFetcher.new
      storefrontFetcher.on_success { |itunes_id| fail }
      storefrontFetcher.on_fail do |itunes_id|
        itunes_id.should eql "nope"
      end
      storefrontFetcher.fetch( "nope", 'us' )
    end
  end
end