# frozen_string_literal: true

require_relative "lib/latest_stock_price/version"

Gem::Specification.new do |spec|
  spec.name = "latest_stock_price"
  spec.version = LatestStockPrice::VERSION
  spec.authors = ["nataliia-veselska"]
  spec.email = ["nataliia.veselska@onix-systems.com"]

  spec.summary = "Gem for fetching data from latest stock price API"
  spec.description = "Gem for fetching data from latest stock price API."
  spec.homepage = "https://example.com/latest_stock_price"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://example.com/latest_stock_price"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # gemspec = File.basename(__FILE__)
  spec.files = Dir["lib/**/*.rb"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
