# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2018-2024, by Samuel Williams.

require 'xrb/parsers'
require 'xrb/builder'
require 'xrb/entities'

module XRB
	module Sanitize
		# Provides a high level interface for parsing markup.
		class Filter
			TAG = 1
			
			DOCTYPE = 2
			COMMENT = 4
			INSTRUCTION = 8
			CDATA = 16
			TEXT = 32
			
			CONTENT = DOCTYPE | COMMENT | INSTRUCTION | CDATA | TEXT
			ALL = TAG | CONTENT
			
			def self.parse(input, output = nil, entities = XRB::Entities::HTML5)
				# This allows us to handle passing in a string:
				input = XRB::Buffer(input)
				
				output ||= MarkupString.new.force_encoding(input.encoding)
				
				delegate = self.new(output, entities)
				
				delegate.parse!(input)
				
				return delegate
			end
			
			Node = Struct.new(:name, :tag, :skip) do
				def skip!(mode = ALL)
					self.skip |= mode
				end
				
				def skip?(mode = ALL)
					(self.skip & mode) == mode
				end
				
				def accept!(mode = ALL)
					self.skip &= ~mode
				end
				
				def [] key
					self.tag&.attributes[key]
				end
				
				def limit_attributes(keys)
					self.tag&.attributes&.select!{|key, value| keys.include?(key)}
				end
			end
			
			def initialize(output, entities)
				@output = output
				
				@entities = entities
				
				@current = nil
				@stack = []
				
				@current = @top = Node.new(nil, nil, 0)
				
				@skip = nil
			end
			
			attr :output
			
			# The current node being parsed.
			attr :current
			
			attr :stack
			
			def top
				@stack.last || @top
			end
			
			def parse!(input)
				parse_begin
				
				XRB::Parsers.parse_markup(input, self, @entities)
				
				parse_end
				
				return self
			end
			
			def parse_begin
			end
			
			def parse_end
				while @stack.size > 1
					close_tag(@stack.last.name)
				end
			end
			
			def open_tag_begin(name, offset)
				tag = Tag.new(name, false, {})
				
				@current = Node.new(name, tag, current.skip)
			end
			
			def attribute(key, value)
				@current.tag.attributes[key] = value
			end
			
			def open_tag_end(self_closing)
				if self_closing
					@current.tag.closed = true
				else
					@stack << @current
				end
				
				filter(@current)
				
				@current.tag.write_opening_tag(@output) unless @current.skip? TAG
				
				# If the tag was self-closing, it's no longer current at this point, we are back in the context of the parent tag.
				@current = self.top if self_closing
			end
			
			def close_tag(name, offset = nil)
				while node = @stack.pop
					node.tag.write_closing_tag(@output) unless node.skip? TAG
					
					break if node.name == name
				end
				
				@current = self.top
			end
			
			def filter(tag)
				return tag
			end
			
			def doctype(string)
				@output << string unless current.skip? DOCTYPE
			end
			
			def comment(string)
				@output << string unless current.skip? COMMENT
			end
			
			def instruction(string)
				@output << string unless current.skip? INSTRUCTION
			end
			
			def cdata(string)
				@output << string unless current.skip? CDATA
			end
			
			def text(string)
				Markup.append(@output, string) unless current.skip? TEXT
			end
		end
	end
end
