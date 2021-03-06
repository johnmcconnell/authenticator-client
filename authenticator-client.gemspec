# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'authenticator/client/version'

Gem::Specification.new do |spec|
  spec.name          = "authenticator-client"
  spec.version       = Authenticator::Client::VERSION
  spec.authors       = ["johnmcconnell"]
  spec.email         = ["johnnyillinois@gmail.com"]
  spec.summary       = %q{This is a rest client for account authenticator.}
  spec.description   = %q{This is a rest client for account authenticator.}
  spec.homepage      = "https://github.com/johnmcconnell/authenticator-client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]


  spec.add_dependency 'attr_init', '~> 0.0.4'
  spec.add_dependency 'rest-client', '~> 1.7.2'
  spec.add_dependency 'json_client', '~> 0.2.2'

  spec.add_development_dependency "simplecov", "~> 0.8.0"
  spec.add_development_dependency "coveralls", "~> 0.7.0"

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-collection_matchers"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
end
