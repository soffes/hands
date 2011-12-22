require 'spec_helper'

describe Hands::Hand do
  # it 'should order hands' do
  #   hand1 = Hands::Hand.new
  #   hand1 << Hands::Card.new(:value => 2, :suite => :hearts)
  #   hand1 << Hands::Card.new(:value => 2, :suite => :clubs)
  #   
  #   hand2 = Hands::Hand.new
  #   hand2 << Hands::Card.new(:value => 'A', :suite => :hearts)
  #   hand2 << Hands::Card.new(:value => 'A', :suite => :clubs)
  #   
  #   (hand2 > hand1).should eq(true)
  # end
  
  it 'should collect suites' do
    hand1 = Hands::Hand.new
    hand1 << Hands::Card.new(:value => 2, :suite => :hearts)
    hand1 << Hands::Card.new(:value => 2, :suite => :clubs)
    hand1.suites.should eq([:hearts, :clubs])
    
    hand1 << Hands::Card.new(:value => 3, :suite => :clubs)
    hand1.suites.should eq([:hearts, :clubs])
  end
end
