source 'https://rubygems.org'

# Specify your gem's dependencies in trenni.gemspec
gemspec

group :maintenance, optional: true do
	gem "bake-modernize"
	gem "bake-bundler"
end

group :test do
	gem 'ruby-prof', platforms: [:mri]
	gem "benchmark-ips"
	
	# For comparisons:
	gem "sanitize"
end
