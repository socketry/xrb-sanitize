# XRB::Sanitize

Sanitize markup by adding, changing or removing tags, using the [xrb](https://github.com/ioquatix/xrb) stream processor (which has a naive C implementation).

[![Development Status](https://github.com/socketry/xrb-sanitize/workflows/Test/badge.svg)](https://github.com/socketry/xrb-sanitize/actions?workflow=Test)

## Motivation

I use the [sanitize](https://github.com/rgrove/sanitize/) gem and generally it's great. However, it's performance can be an issue and additionally, it doesn't preserve tag namespaces when parsing fragments due to how Nokogiri works internally. This is a problem when processing content destined for [utopia](https://github.com/ioquatix/utopia) since it heavily depends on tag namespaces.

## Is it fast?

In my informal testing, this gem is about \~50x faster than the [sanitize](https://github.com/rgrove/sanitize/) gem when generating plain text.

    ruby 3.3.0 (2023-12-25 revision 5124f9ac75) [x86_64-linux]
    Warming up --------------------------------------
                Sanitize   438.000 i/100ms
           XRB::Sanitize     7.935k i/100ms
    Calculating -------------------------------------
                Sanitize      4.365k (± 0.1%) i/s -     21.900k in   5.017157s
           XRB::Sanitize     78.670k (± 0.1%) i/s -    396.750k in   5.043233s
    
    Comparison:
           XRB::Sanitize:    78669.9 i/s
                Sanitize:     4365.0 i/s - 18.02x  slower

## Usage

Please see the [project documentation](https://socketry.github.io/xrb-sanitize/) for more details.

  - [Getting Started](https://socketry.github.io/xrb-sanitize/guides/getting-started/index) - This guide explains how to get started with the `XRB::Sanitize` gem.

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
