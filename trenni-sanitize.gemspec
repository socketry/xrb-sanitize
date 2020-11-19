
require_relative "lib/trenni/sanitize/version"

Gem::Specification.new do |spec|
	spec.name = "trenni-sanitize"
	spec.version = Trenni::Sanitize::VERSION
	
	spec.summary = "Sanitize markdown according to a set of rules."
	spec.authors = ["Samuel Williams"]
	spec.license = "MIT"
	
	spec.homepage = "https://github.com/ioquatix/trenni-sanitize"
	
	spec.metadata = {
		"funding_uri" => "https://github.com/sponsors/ioquatix/",
	}
	
	spec.files = Dir.glob('{lib}/**/*', File::FNM_DOTMATCH, base: __dir__)
	
	spec.required_ruby_version = ">= 2.5"
	
	spec.add_dependency "trenni", "~> 3.5"
	
	spec.add_development_dependency "bundler"
	spec.add_development_dependency "covered"
	spec.add_development_dependency "rspec", "~> 3.4"
end
