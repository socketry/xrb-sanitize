# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2018-2024, by Samuel Williams.

require_relative 'filter'

module XRB
	module Sanitize
		class Text < Filter
			CLOSING = {
				"p" => "\n\n",
				"div" => "\n\n",
			}
			
			def filter(node)
				if node.name == "br"
					text("\n\n")
				end
				
				if node.name == 'script'
					node.skip!(ALL) # Skip everything including content.
				else
					node.skip!(TAG) # Only skip the tag output, but not the content.
				end
			end
			
			def close_tag(name, offset = nil)
				super
				
				if value = CLOSING[name]
					text(value)
				end
			end
			
			def doctype(string)
			end
			
			def comment(string)
			end
			
			def instruction(string)
			end
			
			def cdata(string)
			end
		end
	end
end
