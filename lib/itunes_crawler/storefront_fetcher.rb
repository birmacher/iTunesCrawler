require "typhoeus"
require "itunes_crawler/storefront_fetcher/callback"
require "itunes_crawler/storefront_fetcher/fetcher"

module ITunesCrawler

  class StorefrontFetcher
    include StorefrontFetcher::Callback
    include StorefrontFetcher::Fetcher
  
    attr_accessor :retry_count
  
    def initialize( retry_count=5 )
      @retry_count = retry_count
      @hydra = Typhoeus::Hydra.new
    end
    
  end
  
end
