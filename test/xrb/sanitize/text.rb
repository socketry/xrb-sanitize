# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2018-2024, by Samuel Williams.

require 'xrb/sanitize/text'

describe XRB::Sanitize::Text do
	let(:text) {"One\n\nTwo\n\nThree\n\n"}
	
	it "passes through plain text unchanged" do
		fragment = subject.parse(text)
		
		expect(fragment.output).to be == text
	end
	
	it "should extract text" do
		fragment = subject.parse("<p onclick='malicious()'>Hello World</p><script>doot()</script>")
		
		expect(fragment.output).to be == "Hello World\n\n"
	end
	
	it "replaces line breaks" do
		fragment = subject.parse("One<br/>Two<br/>Three")
		
		expect(fragment.output).to be == "One\n\nTwo\n\nThree"
	end
end
