# Moments [![Gem Version](https://badge.fury.io/rb/moments.svg)](http://badge.fury.io/rb/moments)

[![Codeship Status for excpt/moments](https://codeship.com/projects/54ff9970-675f-0132-a1ba-760b27c1e7ed/status?branch=master)](https://codeship.com/projects/53081)
[![Build Status](https://travis-ci.org/excpt/moments.svg?branch=master)](https://travis-ci.org/excpt/moments)
[![Code Climate](https://codeclimate.com/github/excpt/moments.png)](https://codeclimate.com/github/excpt/moments)
[![Test Coverage](https://codeclimate.com/github/excpt/moments/badges/coverage.svg)](https://codeclimate.com/github/excpt/moments)
[![Dependency Status](https://gemnasium.com/excpt/moments.svg)](https://gemnasium.com/excpt/moments)

Handles time differences and calculations.

## Installation

Add this line to your application's Gemfile:

    gem 'moments'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install moments

## Usage

```ruby
require 'moments'

t1 = Time.now
t2 = Time.new 2020, 1, 1

# Important: For now t1 must be equal or less than t2
diff = Moments.difference t1, t2

puts diff.to_hash
# Output {:years=>5, :months=>7, :days=>5, :hours=>19, :minutes=>29, :seconds=>6}
```

## Contributing

1. Fork it ( https://github.com/excpt/moments/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
