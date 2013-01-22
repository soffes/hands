require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'
Bundler.require :test
require 'minitest/autorun'
require 'hands'

class Hands::TestCase < MiniTest::Unit::TestCase
end
