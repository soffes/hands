require 'rubygems'
require 'bundler'
Bundler.require :test

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'hands'

# Support files
Dir["#{File.expand_path(File.dirname(__FILE__))}/support/*.rb"].each do |file|
  require file
end

class Hands::TestCase < MiniTest::Unit::TestCase
end
