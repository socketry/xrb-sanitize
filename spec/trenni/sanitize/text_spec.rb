# Copyright, 2019, by Samuel G. D. Williams. <http://www.codeotaku.com>
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

require 'trenni/sanitize/text'

RSpec.describe Trenni::Sanitize::Text do
	let(:text) {"One\n\nTwo\n\nThree\n\n"}
	
	it "passes through plain text unchanged" do
		fragment = described_class.parse(text)
		
		expect(fragment.output).to be == text
	end
	
	it "should extract text" do
		fragment = described_class.parse("<p onclick='malicious()'>Hello World</p><script>doot()</script>")
		
		expect(fragment.output).to be == "Hello World\n\n"
	end
	
	it "replaces line breaks" do
		fragment = described_class.parse("One<br/>Two<br/>Three")
		
		expect(fragment.output).to be == "One\n\nTwo\n\nThree"
	end
end
