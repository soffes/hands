# Hands

Simple library for calculating poker hands.

Currently this gem is very limited. I plan on adding outs, odds, and other actually useful stuff. I started writing this on a plane as a personal challenge. It's current state is crude, although tested and works.

[![Build Status](https://travis-ci.org/soffes/hands.png?branch=master)](undefined) [![Dependency Status](https://gemnasium.com/soffes/hands.png)](https://gemnasium.com/soffes/hands) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/soffes/hands)

## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'hands'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hands

## Usage

Read the [documentation](http://rubydoc.info/github/soffes/hands/frames/file/Readme.markdown).

``` ruby
# Best hand detection
straight = Hands::Hand.new
straight << Hands::Card['A', :hearts]
straight << Hands::Card[2, :spades]
straight << Hands::Card[3, :diamonds]
straight << Hands::Card[4, :hearts]
straight << Hands::Card[5, :clubs]
straight.best_hand[:type] # :straight

# Hand comparison
pair = Hands::Hand.new
pair << Hands::Card[2, :hearts]
pair << Hands::Card[2, :clubs]
pair << Hands::Card[3, :diamonds]
pair << Hands::Card[4, :hearts]
pair << Hands::Card[5, :clubs]

flush = Hands::Hand.new
flush << Hands::Card[6, :hearts]
flush << Hands::Card[7, :hearts]
flush << Hands::Card[8, :hearts]
flush << Hands::Card[2, :hearts]
flush << Hands::Card[4, :hearts]
flush > pair # true

# Card comparison
card1 = Hands::Card.new(:value => 2, :suit => :hearts)
card2 = Hands::Card.new(:value => 3, :suit => :clubs)
card2 > card1 # true
```

## Running Tests

Running and reading the tests is (for now) the best way to see the functionality of this gem.

```
$ bundle exec rake
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write passing specs
4. Write documentation
5. Commit your changes (`git commit -am 'Added some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create new Pull Request
