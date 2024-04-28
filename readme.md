# XRB::Sanitize

Sanitize markup by adding, changing or removing tags, using the [xrb](https://github.com/ioquatix/xrb) stream processor (which has a naive C implementation).

[![Development Status](https://github.com/socketry/xrb-sanitize/workflows/Test/badge.svg)](https://github.com/socketry/xrb-sanitize/actions?workflow=Test)

## Motivation

I use the [sanitize](https://github.com/rgrove/sanitize/) gem and generally it's great. However, it's performance can be an issue and additionally, it doesn't preserve tag namespaces when parsing fragments due to how Nokogiri works internally. This is a problem when processing content destined for [utopia](https://github.com/ioquatix/utopia) since it heavily depends on tag namespaces.

## Is it fast?

In my informal testing, this gem is about \~50x faster than the [sanitize](https://github.com/rgrove/sanitize/) gem when generating plain text.

    Warming up --------------------------------------
    			Sanitize    96.000  i/100ms
    		XRB::Sanitize     4.447k i/100ms
    Calculating -------------------------------------
    			Sanitize    958.020  (± 4.5%) i/s -      4.800k in   5.020564s
    		XRB::Sanitize     44.718k (± 4.2%) i/s -    226.797k in   5.080756s
    
    Comparison:
    		XRB::Sanitize:    44718.1 i/s
    			Sanitize:      958.0 i/s - 46.68x  slower

## Installation

Add this line to your application's Gemfile:

    gem 'xrb-sanitize'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xrb-sanitize

## Usage

`XRB::Sanitize::Delegate` is a stream-based processor. That means it parses the incoming markup and makes decisions about what to keep and what to discard during parsing.

### Extracting Text

You can extract text using something similar to the following parser delegate:

``` ruby
class Text < XRB::Sanitize::Filter
	def filter(node)
		node.skip!(TAG)
	end
	
	def doctype(string)
	end
	
	def instruction(string)
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

As you can see, while [sanitize](https://github.com/rgrove/sanitize/) is driven by configuration, `XRB::Sanitize::Filter` is driven by code.

## Contributing

We welcome contributions to this project.

1.  Fork it.
2.  Create your feature branch (`git checkout -b my-new-feature`).
3.  Commit your changes (`git commit -am 'Add some feature'`).
4.  Push to the branch (`git push origin my-new-feature`).
5.  Create new Pull Request.

### Developer Certificate of Origin

This project uses the [Developer Certificate of Origin](https://developercertificate.org/). All contributors to this project must agree to this document to have their contributions accepted.

### Contributor Covenant

This project is governed by the [Contributor Covenant](https://www.contributor-covenant.org/). All contributors and participants agree to abide by its terms.
