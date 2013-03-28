## ITunesCrawler
[![Build Status](https://travis-ci.org/birmacher/iTunesCrawler.png)](https://travis-ci.org/birmacher/iTunesCrawler)
[![Code Climate](https://codeclimate.com/github/birmacher/iTunesCrawler.png)](https://codeclimate.com/github/birmacher/iTunesCrawler)

ITunesCrawler provides an easy way to download the requested iTunes data through Apple's Search API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itunes_crawler'
```

And then execute:

```console
$ bundle
```

Or install it yourself as:

```console
$ gem install itunes_crawler
```

## Usage

### Download iTunes info for a single app

```ruby
storefrontFetcher = ITunesCrawler::StorefrontFetcher.new
storefrontFetcher.on_success { |itunes_item| p itunes_item["trackName"] }
storefrontFetcher.on_fail { |app_id| p "Nooooooo" }
storefrontFetcher.fetch( '557137623', 'us' )
```

### Download iTunes info for multiple apps

```ruby
storefrontFetcher = ITunesCrawler::StorefrontFetcher.new
storefrontFetcher.on_success { |itunes_item| p itunes_item["trackName"] }
storefrontFetcher.on_fail { |app_id| p "Nooooooo" }
storefrontFetcher.fetch( ['557137623', '284882215'], 'us' )
```

### Change retry count of failed requests

```ruby
storefrontFetcher = ITunesCrawler::StorefrontFetcher.new( 1 )
```

or 

```ruby
storefrontFetcher = ITunesCrawler::StorefrontFetcher.new
storefrontFetcher.retry_count = 1
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License
MIT license