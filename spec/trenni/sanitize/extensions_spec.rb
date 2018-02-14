
require 'trenni/sanitize/extensions'

RSpec.describe Hash do
	let(:hash) {{x: 10, y: 20, z: 30}}
	
	it "can slice the hash" do
		result = hash.slice(:x)
		
		expect(hash.size).to be == 3
		expect(result.size).to be == 1
		
		expect(result[:x]).to be == 10
		expect(result[:y]).to be_nil
		expect(result[:z]).to be_nil
	end
	
	it "can slice! the hash in-place" do
		hash.slice!(:x)
		
		expect(hash.size).to be == 1
		expect(hash[:x]).to be == 10
		expect(hash[:y]).to be_nil
		expect(hash[:z]).to be_nil
	end
end