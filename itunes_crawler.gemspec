# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'itunes_crawler/version'

Gem::Specification.new do |spec|
  spec.name          = "itunes_crawler"
  spec.version       = ITunesCrawler::VERSION
  spec.authors       = ["Barnabas Birmacher"]
  spec.email         = ["birmacher@gmail.com"]
  spec.description   = "ITunesCrawler provides an easy way to download the requested iTunes data through Apple's Search API."
  spec.summary       = "ITunesCrawler provides an easy way to download the requested iTunes data through Apple's Search API."
  spec.homepage      = "https://github.com/birmacher/iTunesCrawler"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_dependency "typhoeus", "~> 0.6.2"
  spec.add_dependency "json", "~> 1.7.7"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
