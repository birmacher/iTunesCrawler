module ITunesCrawler
  class StorefrontFetcher

    module Retryable
      def retryable?(url)
        return false if @retry_count <= 0
      
        @failed_urls ||= {}
        
        # It's our first try
        # save the url and that's all for now
        unless @failed_urls[url]
          @failed_urls[url] = 1
          true
        else
          # No more try for you
          retries = @failed_urls[url]
          if retries + 1 >= @retry_count
            false
          else
            @failed_urls[url] = retries + 1
            true
          end
        end
      end
    end

  end
end