
require_relative 'lib/trenni/sanitize/version'

Gem::Specification.new do |spec|
	spec.name          = "trenni-sanitize"
	spec.platform      = Gem::Platform::RUBY
	spec.version       = Trenni::Sanitize::VERSION
	spec.authors       = ["Samuel Williams"]
	spec.email         = ["samuel.williams@oriontransfer.co.nz"]
	spec.summary       = %q{Sanitize markdown according to a set of rules.}
	spec.homepage      = "https://github.com/ioquatix/trenni-sanitize"

	spec.files         = `git ls-files`.split($/)
	spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
	spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
	spec.require_paths = ["lib"]
	
	spec.required_ruby_version = '~> 2.4'
	
	spec.add_dependency "trenni", '~> 3.5'
	
	spec.add_development_dependency "covered"
	spec.add_development_dependency "bundler"
	spec.add_development_dependency "rspec", "~> 3.4"
	spec.add_development_dependency "rake"
end
