# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2018-2024, by Samuel Williams.

require 'xrb/sanitize/fragment'

describe XRB::Sanitize::Fragment do
	it "should filter out script tags" do
		fragment = subject.parse("<p onclick='malicious()'>Hello World</p><script>doot()</script>")
		
		expect(fragment.output).to be == "<p>Hello World</p>"
	end
	
	it "should filter out nested script tags" do
		fragment = subject.parse("<div><p>Hello World</p><script>doot()</script></div>")
		
		expect(fragment.output).to be == "<div><p>Hello World</p></div>"
	end
	
	it "should filter out tags" do
		fragment = subject.parse("<p onclick='malicious()'>Hello World</p><script>script</script>")
		
		expect(fragment.output).to be == "<p>Hello World</p>"
	end
	
	it "should ignore unbalanced closing tags" do
		fragment = subject.parse("<p>Hello World</a></p>")
		
		expect(fragment.output).to be == "<p>Hello World</p>"
	end
	
	it "should allow list items" do
		input = "<ul><li>Hello World</li></ul>"
		fragment = subject.parse(input)
		expect(fragment.output).to be == input
	end
	
	it "should include trailing text" do
		fragment = subject.parse("Hello<script/>World")
		
		expect(fragment.output).to be == "HelloWorld"
	end
	
	it "should escape text" do
		fragment = subject.parse("x&amp;y")
		
		expect(fragment.output).to be == "x&amp;y"
	end
	
	it "should include nested img" do
		fragment = subject.parse("<table><img src='foo'/></table>")
		
		expect(fragment.output).to be == "<img src=\"foo\"/>"
	end
end

