# trenni-sanitize::Sanitize

Sanitize markup by adding, changing or removing tags. 

[![Build Status](https://secure.travis-ci.org/ioquatix/trenni-sanitize.svg)](http://travis-ci.org/ioquatix/trenni-sanitize)
[![Code Climate](https://codeclimate.com/github/ioquatix/trenni-sanitize.svg)](https://codeclimate.com/github/ioquatix/trenni-sanitize)
[![Coverage Status](https://coveralls.io/repos/ioquatix/trenni-sanitize/badge.svg)](https://coveralls.io/r/ioquatix/trenni-sanitize)

## Motivation

I use the [sanitize] gem and generally it's great. However, it's performance can be an issue and additionally, it doesn't preserve tag namespaces when parsing fragments due to how Nokogiri works internally.

[sanitize]: https://github.com/rgrove/sanitize/

## Is it fast?

In my informal testing, this gem is about ~50x faster than the [sanitize] gem when generating plain text.

```
Warming up --------------------------------------
						Sanitize    96.000  i/100ms
		Trenni::Sanitize     4.447k i/100ms
Calculating -------------------------------------
						Sanitize    958.020  (± 4.5%) i/s -      4.800k in   5.020564s
		Trenni::Sanitize     44.718k (± 4.2%) i/s -    226.797k in   5.080756s

Comparison:
		Trenni::Sanitize:    44718.1 i/s
						Sanitize:      958.0 i/s - 46.68x  slower
```

## Installation

Add this line to your application's Gemfile:

	gem 'trenni-sanitize'

And then execute:

	$ bundle

Or install it yourself as:

	$ gem install trenni-sanitize

## Usage

`Trenni::Sanitize::Delegate` is a stream-based processor. That means it parses the incoming markup and makes decisions about what to keep and what to discard during parsing.

### Extracting Text

You can extract text using something similar to the following parser delegate:

```ruby
class Text < Trenni::Sanitize::Filter
	def filter(node)
		skip!(TAG)
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

```ruby
class Fragment < Trenni::Sanitize::Filter
	STANDARD_ATTRIBUTES = ['class'].freeze
	
	ALLOWED_TAGS = {
		'em' => [],
		'strong' => [],
		'p' => [],
		'img' => [] + ['src', 'alt', 'width', 'height'],
		'a' => ['href', 'target']
	}.freeze
	
	def filter(node)
		if attributes = ALLOWED_TAGS[node.name]
			node.tag.attributes.slice!(attributes)
		else
			# Skip the tag, and all contents
			skip!(ALL)
		end
	end
	
	def doctype(string)
	end
	
	def instruction(string)
	end
end
```

As you can see, while [sanitize] is driven by configuration, `Trenni::Sanitize::Filter` is driven by code.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Released under the MIT license.

Copyright, 2018, by [Samuel G. D. Williams](http://www.codeotaku.com/samuel-williams).

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
