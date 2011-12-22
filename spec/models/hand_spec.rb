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
  
  it 'should recognize high card' do
    hand = Hands::Hand.new
    hand << Hands::Card.new(:value => 2, :suite => :hearts)
    hand << Hands::Card.new(:value => 9, :suite => :clubs)
    hand << Hands::Card.new(:value => 7, :suite => :hearts)
    hand << Hands::Card.new(:value => 'a', :suite => :spades)
    hand << Hands::Card.new(:value => 4, :suite => :diamonds)
    
    hand.high_card.collect(&:value).should eq(['a', 9, 7, 4, 2])
    hand.pair.should eql(nil)
    hand.two_pair.should eql(nil)
  end
  
  it 'should recognize a pair' do
    hand = Hands::Hand.new
    hand << Hands::Card.new(:value => 9, :suite => :hearts)
    hand << Hands::Card.new(:value => 9, :suite => :clubs)
    hand << Hands::Card.new(:value => 7, :suite => :hearts)
    hand << Hands::Card.new(:value => 2, :suite => :spades)
    hand << Hands::Card.new(:value => 4, :suite => :diamonds)
    
    hand.pair.collect(&:value).should eq([9, 9, 7, 4, 2])
    hand.two_pair.should eql(nil)
  end
  
  it 'should recognize two pair'  do
    hand = Hands::Hand.new
    hand << Hands::Card.new(:value => 7, :suite => :hearts)
    hand << Hands::Card.new(:value => 7, :suite => :spades)
    hand << Hands::Card.new(:value => 4, :suite => :diamonds)
    hand << Hands::Card.new(:value => 9, :suite => :hearts)
    hand << Hands::Card.new(:value => 9, :suite => :clubs)
    
    hand.two_pair.collect(&:value).should eq([9, 9, 7, 7, 4])
    hand.two_pair.should eql(hand.pair)
  end
   
  it 'should recognize three of a kind'
  it 'should recognize a straight'
  it 'should recognize a flush'
  it 'should recognize a full house'
  it 'should recognize four of a kind'
  it 'should recognize a straight flush'
end
