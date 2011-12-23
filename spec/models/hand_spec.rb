require 'spec_helper'

describe Hands::Hand do
  it 'should order different types of hands' do
    pair = Hands::Hand.new
    pair << Hands::Card.new(:value => 2, :suite => :hearts)
    pair << Hands::Card.new(:value => 2, :suite => :clubs)
    
    flush = Hands::Hand.new
    flush << Hands::Card.new(:value => 6, :suite => :hearts)
    flush << Hands::Card.new(:value => 7, :suite => :hearts)
    flush << Hands::Card.new(:value => 8, :suite => :hearts)
    flush << Hands::Card.new(:value => 2, :suite => :hearts)
    flush << Hands::Card.new(:value => 4, :suite => :hearts)
    
    (flush > pair).should eq(true)
  end
  
  it 'should order same types of hands' do
    small_pair = Hands::Hand.new
    small_pair << Hands::Card.new(:value => 2, :suite => :hearts)
    small_pair << Hands::Card.new(:value => 2, :suite => :clubs)
    
    large_pair = Hands::Hand.new
    large_pair << Hands::Card.new(:value => 'A', :suite => :hearts)
    large_pair << Hands::Card.new(:value => 'A', :suite => :clubs)
    
    (large_pair > small_pair).should eq(true)
    
    small_kicker = Hands::Hand.new
    small_kicker << Hands::Card.new(:value => 'A', :suite => :spades)
    small_kicker << Hands::Card.new(:value => 'A', :suite => :diamonds)
    small_kicker << Hands::Card.new(:value => 2, :suite => :diamonds)
    small_kicker << Hands::Card.new(:value => 3, :suite => :diamonds)
    small_kicker << Hands::Card.new(:value => 4, :suite => :diamonds)
    
    big_kicker = Hands::Hand.new
    big_kicker << Hands::Card.new(:value => 'A', :suite => :hearts)
    big_kicker << Hands::Card.new(:value => 'A', :suite => :clubs)
    big_kicker << Hands::Card.new(:value => 10, :suite => :diamonds)
    big_kicker << Hands::Card.new(:value => 9, :suite => :diamonds)
    big_kicker << Hands::Card.new(:value => 7, :suite => :diamonds)
    
    (big_kicker > small_kicker).should eq(true)
  end
  
  it 'should collect suites' do
    hand = Hands::Hand.new
    hand << Hands::Card.new(:value => 2, :suite => :hearts)
    hand << Hands::Card.new(:value => 2, :suite => :clubs)
    hand.suites.should eq([:hearts, :clubs])
    
    hand << Hands::Card.new(:value => 3, :suite => :clubs)
    hand.suites.should eq([:hearts, :clubs])
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
  
  it 'should recognize a flush' do
    hand = Hands::Hand.new
    hand << Hands::Card.new(:value => 6, :suite => :hearts)
    hand << Hands::Card.new(:value => 7, :suite => :hearts)
    hand << Hands::Card.new(:value => 8, :suite => :hearts)
    hand << Hands::Card.new(:value => 2, :suite => :hearts)
    hand << Hands::Card.new(:value => 4, :suite => :hearts)
    
    hand.best_hand[:type].should eq('flush')
  end
  
  it 'should recognize a full house'
  it 'should recognize four of a kind'
  it 'should recognize a straight flush'
  
  it 'should recognize the best hand'  do
    hand = Hands::Hand.new
    hand << Hands::Card.new(:value => 7, :suite => :hearts)
    hand << Hands::Card.new(:value => 7, :suite => :spades)
    hand << Hands::Card.new(:value => 4, :suite => :diamonds)
    hand << Hands::Card.new(:value => 9, :suite => :hearts)
    hand << Hands::Card.new(:value => 9, :suite => :clubs)
    
    hand.best_hand[:type].should eq('two_pair')
  end
end
