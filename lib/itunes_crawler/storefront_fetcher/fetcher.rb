require "json"
require "cgi"
require "itunes_crawler/storefront_fetcher/retryable"

module ITunesCrawler
  class StorefrontFetcher

    module Fetcher
      include StorefrontFetcher::Retryable
      
      # Download iTunes item data
      def fetch(itunes_ids, country_code)
        # Save iTunes IDs to an array
        ( ( queue ||= [] ) << itunes_ids ).flatten!

        # Slice the array to multiple arrays with size of 200
        chunks = queue.each_slice( 200 ).to_a
        chunks.each do |chunk|
          add_url_to_queue "https://itunes.apple.com/lookup?id=#{chunk.join(",")}&country=#{country_code}", false
        end
        @hydra.run
      end
      
      private
      
      def add_url_to_queue(url, start=true)
        request = Typhoeus::Request.new( url, :followlocation => true )
        
        # Callbacks
        request.on_success do |response|
          return unless @success_block
          
          # Save response
          json_response = JSON.parse(response.body)
          itunes_data = json_response["results"]
          
          # Also a failed request if there is no itunes_data
          if !itunes_data ||
             itunes_data.empty?
             
            get_failed_itunes_ids( response.request.base_url )
          else
            # Parse downloaded data
            itunes_data.each do |itunes_item|
              @success_block.call itunes_item
            end
          end
        end
        
        request.on_failure do |response|
          failed_url = response.request.base_url
          
          if retryable?( failed_url )
            add_url_to_queue( failed_url )
          else
            get_failed_itunes_ids( failed_url )          
          end
        end
   
        # Add to queue and start if requested
        @hydra.queue request
        @hydra.run if start
      end
    end
    
    private
    
    def get_failed_itunes_ids_from_url(url)
       CGI.parse(URI(url).query)["id"].first.split( "," )
    end
    
    def get_failed_itunes_ids( url )
      return unless @fail_block
      
      get_failed_itunes_ids_from_url( url ).each do |itunes_id|
        @fail_block.call( itunes_id )
      end
    end
    
  end
end