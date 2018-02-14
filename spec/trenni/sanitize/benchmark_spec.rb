
require 'sanitize'
require 'benchmark/ips'

require 'trenni/sanitize/text'

RSpec.describe Trenni::Sanitize do
	let(:buffer) {Trenni::Buffer.load_file(File.join(__dir__, "sample.html"))}
	
	it "should be faster than alternatives" do
		config = Sanitize::Config.freeze_config(
			:elements => %w[b i em strong ul li strike h1 h2 h3 h4 h5 h6 p img image a],
			:attributes => {
				'img' => %w[src alt width],
				'a' => %w[href]
			},
		)
		
		text = buffer.read
		
		puts Sanitize.fragment(text).inspect
		puts Trenni::Sanitize::Text.parse(buffer).output.inspect
		
		Benchmark.ips do |x|
			x.report("Sanitize") do
				Sanitize.fragment text
			end
			
			x.report("Trenni::Sanitize") do
				Trenni::Sanitize::Text.parse(buffer)
			end
			
			x.compare!
		end
	end
end
