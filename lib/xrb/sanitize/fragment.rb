# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2018-2024, by Samuel Williams.

require_relative 'filter'

require 'set'

module XRB
	module Sanitize
		class Fragment < Filter
			STANDARD_ATTRIBUTES = Set.new(['class', 'style']).freeze
			
			ALLOWED_TAGS = {
				'div' => STANDARD_ATTRIBUTES,
				'span' => STANDARD_ATTRIBUTES,
				'br' => STANDARD_ATTRIBUTES,
				'b' => STANDARD_ATTRIBUTES,
				'i' => STANDARD_ATTRIBUTES,
				'em' => STANDARD_ATTRIBUTES,
				'strong' => STANDARD_ATTRIBUTES,
				'ul' => STANDARD_ATTRIBUTES,
				'ol' => STANDARD_ATTRIBUTES,
				'li' => STANDARD_ATTRIBUTES,
				'dl' => STANDARD_ATTRIBUTES,
				'dt' => STANDARD_ATTRIBUTES,
				'dd' => STANDARD_ATTRIBUTES,
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
					node.limit_attributes(attributes)
					
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
