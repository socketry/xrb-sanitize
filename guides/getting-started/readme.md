# Getting Started

This guide explains how to get started with the `XRB::Sanitize` gem.

## Installation

Add the gem to your project:

``` bash
$ bundle add xrb-sanitize
```

## Core Concepts

- {ruby XRB::Sanitize::Delegate} is a stream-based processor. That means it parses the incoming markup and makes decisions about what to keep and what to discard during parsing.
- {ruby XRB::Sanitize::Filter} is a base class for creating custom filters. You can subclass this to implement your own filtering logic.
- {ruby XRB::Sanitize::Node} is a node in the parse tree. It represents a tag, text, or other content in the markup, which can be filtered or modified.

### Extracting Text

You can extract text using something similar to the following parser delegate:

``` ruby
class Text < XRB::Sanitize::Filter
	def filter(node)
		# Skip any nodes that aren't text:
		node.skip!(TAG)
	end
	
	def doctype(string)
		# Ignore doctype.
	end
	
	def instruction(string)
		# Ignore processing instructions.
	end
end

text = Text.parse("<p>Hello World</p>").output
# => "Hello World"
```

### Extracting Safe Markup

Here is a simple filter that only allows a limited set of tags:

``` ruby
class Fragment < XRB::Sanitize::Filter
	STANDARD_ATTRIBUTES = ['class'].freeze
	
	ALLOWED_TAGS = {
		'em' => [],
		'strong' => [],
		'p' => [],
		'img' => ['src', 'alt', 'width', 'height'],
		'a' => ['href']
	}.freeze
	
	def filter(node)
		if attributes = ALLOWED_TAGS[node.name]
			node.tag.attributes.slice!(*attributes)
		else
			# Skip the tag, and all contents
			node.skip!(ALL)
		end
	end
	
	def doctype(string)
	end
	
	def instruction(string)
	end
end
```
