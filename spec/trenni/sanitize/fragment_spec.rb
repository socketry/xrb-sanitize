# Copyright, 2018, by Samuel G. D. Williams. <http://www.codeotaku.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'trenni/sanitize/fragment'

RSpec.describe Trenni::Sanitize::Fragment do
	it "should filter out script tags" do
		fragment = described_class.parse("<p onclick='malicious()'>Hello World</p><script>doot()</script>")
		
		expect(fragment.output).to be == "<p>Hello World</p>"
	end
	
	it "should filter out nested script tags" do
		fragment = described_class.parse("<div><p>Hello World</p><script>doot()</script></div>")
		
		expect(fragment.output).to be == "<div><p>Hello World</p></div>"
	end
	
	it "should filter out tags" do
		fragment = described_class.parse("<p onclick='malicious()'>Hello World</p><script>script</script>")
		
		expect(fragment.output).to be == "<p>Hello World</p>"
	end
	
	it "should ignore unbalanced closing tags" do
		fragment = described_class.parse("<p>Hello World</a></p>")
		
		expect(fragment.output).to be == "<p>Hello World</p>"
	end
	
	it "should allow list items" do
		input = "<ul><li>Hello World</li></ul>"
		fragment = described_class.parse(input)
		expect(fragment.output).to be == input
	end
	
	it "should include trailing text" do
		fragment = described_class.parse("Hello<script/>World")
		
		expect(fragment.output).to be == "HelloWorld"
	end
	
	it "should escape text" do
		fragment = described_class.parse("x&amp;y")
		
		expect(fragment.output).to be == "x&amp;y"
	end
	
	it "should include nested img" do
		fragment = described_class.parse("<table><img src='foo'/></table>")
		
		expect(fragment.output).to be == "<img src=\"foo\"/>"
	end
end

