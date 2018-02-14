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

require_relative 'filter'

module Trenni
	module Sanitize
		class Fragment < Filter
			STANDARD_ATTRIBUTES = ['class', 'style'].freeze
			
			ALLOWED_TAGS = {
				'div' => STANDARD_ATTRIBUTES,
				'span' => STANDARD_ATTRIBUTES,
				'br' => STANDARD_ATTRIBUTES,
				'b' => STANDARD_ATTRIBUTES,
				'i' => STANDARD_ATTRIBUTES,
				'em' => STANDARD_ATTRIBUTES,
				'strong' => STANDARD_ATTRIBUTES,
				'ul' => STANDARD_ATTRIBUTES,
				'strike' => STANDARD_ATTRIBUTES,
				'h1' => STANDARD_ATTRIBUTES,
				'h2' => STANDARD_ATTRIBUTES,
				'h3' => STANDARD_ATTRIBUTES,
				'h4' => STANDARD_ATTRIBUTES,
				'h5' => STANDARD_ATTRIBUTES,
				'h6' => STANDARD_ATTRIBUTES,
				'p' => STANDARD_ATTRIBUTES,
				'img' => STANDARD_ATTRIBUTES + ['src', 'alt', 'width', 'height'],
				'image' => STANDARD_ATTRIBUTES,
				'a' => STANDARD_ATTRIBUTES + ['href', 'target']
			}.freeze
			
			def filter(node)
				if attributes = ALLOWED_TAGS[node.name]
					node.tag.attributes.slice!(*attributes)
					
					node.accept!
				else
					node.skip!
				end
			end
			
			def doctype(string)
			end
			
			def instruction(string)
			end
		end
	end
end
