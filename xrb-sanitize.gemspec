# frozen_string_literal: true

require_relative "lib/xrb/sanitize/version"

Gem::Specification.new do |spec|
	spec.name = "xrb-sanitize"
	spec.version = XRB::Sanitize::VERSION
	
	spec.summary = "Sanitize markup according to a set of rules."
	spec.authors = ["Samuel Williams"]
	spec.license = "MIT"
	
	spec.cert_chain  = ['release.cert']
	spec.signing_key = File.expand_path('~/.gem/release.pem')
	
	spec.homepage = "https://github.com/ioquatix/xrb-sanitize"
	
	spec.metadata = {
		"documentation_uri" => "https://socketry.github.io/xrb-sanitize/",
		"funding_uri" => "https://github.com/sponsors/ioquatix/",
		"source_code_uri" => "https://github.com/ioquatix/xrb-sanitize.git",
	}
	
	spec.files = Dir.glob(['{lib}/**/*', '*.md'], File::FNM_DOTMATCH, base: __dir__)
	
	spec.required_ruby_version = ">= 3.1"
	
	spec.add_dependency "xrb", "~> 0.3"
end
