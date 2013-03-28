module ITunesCrawler
  class StorefrontFetcher

    module Callback
      # Completetion block
      def on_success(&block)
        @success_block = block if block_given?
        @success_block
      end
      
      def on_fail(&block)
        @fail_block = block if block_given?
        @fail_block
      end
    end
    
  end
end