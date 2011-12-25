require 'spec_helper'

describe Hands::Hand, '#<=>' do
  it 'should order different types of hands' do
    pair = Hands::Hand.new
    pair << Hands::Card[2, :hearts]
    pair << Hands::Card[2, :clubs]

    flush = Hands::Hand.new
    flush << Hands::Card[6, :hearts]
    flush << Hands::Card[7, :hearts]
    flush << Hands::Card[8, :hearts]
    flush << Hands::Card[2, :hearts]
    flush << Hands::Card[4, :hearts]
    (flush > pair).should be_true
  end

  it 'should order same types of hands' do
    small_pair = Hands::Hand.new
    small_pair << Hands::Card[2, :hearts]
    small_pair << Hands::Card[2, :clubs]

    large_pair = Hands::Hand.new
    large_pair << Hands::Card['A', :hearts]
    large_pair << Hands::Card['A', :clubs]
    (large_pair > small_pair).should be_true

    small_kicker = Hands::Hand.new
    small_kicker << Hands::Card['A', :spades]
    small_kicker << Hands::Card['A', :diamonds]
    small_kicker << Hands::Card[2, :diamonds]
    small_kicker << Hands::Card[3, :diamonds]
    small_kicker << Hands::Card[4, :diamonds]

    big_kicker = Hands::Hand.new
    big_kicker << Hands::Card['A', :hearts]
    big_kicker << Hands::Card['A', :clubs]
    big_kicker << Hands::Card[10, :diamonds]
    big_kicker << Hands::Card[9, :diamonds]
    big_kicker << Hands::Card[7, :diamonds]
    (big_kicker > small_kicker).should be_true
  end
end

describe Hands::Hand, '#suites' do
  it 'should collect suites' do
    hand = Hands::Hand.new
    hand << Hands::Card[2, :hearts]
    hand << Hands::Card[2, :clubs]
    hand.suites.should eq([:hearts, :clubs])

    hand << Hands::Card[3, :clubs]
    hand.suites.should eq([:hearts, :clubs])
  end
end

describe Hands::Hand, '#high_card' do
  it 'should recognize high card' do
    hand = Hands::Hand.new
    hand << Hands::Card[2, :hearts]
    hand << Hands::Card[9, :clubs]
    hand << Hands::Card[7, :hearts]
    hand << Hands::Card['a', :spades]
    hand << Hands::Card[4, :diamonds]
    hand.high_card.collect(&:value).should eq(%w{a 9 7 4 2})
    hand.pair.should eq(nil)
    hand.two_pair.should eq(nil)
  end
end

describe Hands::Hand, '#pair' do
  it 'should recognize a pair' do
    hand = Hands::Hand.new
    hand << Hands::Card[9, :hearts]
    hand << Hands::Card[9, :clubs]
    hand << Hands::Card[7, :hearts]
    hand << Hands::Card[2, :spades]
    hand << Hands::Card[4, :diamonds]
    hand.pair.collect(&:value).should eq(%w{9 9 7 4 2})
    hand.two_pair.should eq(nil)
  end
end

describe Hands::Hand, '#two_pair' do
  it 'should recognize two pair'  do
    hand = Hands::Hand.new
    hand << Hands::Card[7, :hearts]
    hand << Hands::Card[7, :spades]
    hand << Hands::Card[4, :diamonds]
    hand << Hands::Card[9, :hearts]
    hand << Hands::Card[9, :clubs]
    hand.two_pair.collect(&:value).should eq(%w{9 9 7 7 4})
    hand.two_pair.should eq(hand.pair)
  end
end

describe Hands::Hand, '#three_of_a_kind' do
  it 'should recognize three of a kind' do
    hand = Hands::Hand.new
    hand << Hands::Card[7, :hearts]
    hand << Hands::Card[7, :spades]
    hand << Hands::Card[7, :diamonds]
    hand << Hands::Card[3, :hearts]
    hand << Hands::Card[9, :clubs]
    hand.best_hand[:type].should eq('three_of_a_kind')
  end
end

describe Hands::Hand, '#straight' do
  it 'should recognize a straight' do
    hand = Hands::Hand.new
    hand << Hands::Card[2, :hearts]
    hand << Hands::Card[3, :spades]
    hand << Hands::Card[4, :diamonds]
    hand << Hands::Card[5, :hearts]
    hand << Hands::Card[6, :clubs]
    hand.best_hand[:type].should eq('straight')
  end
  
  it 'should recognize a straight when ace is low' do
    hand = Hands::Hand.new
    hand << Hands::Card['A', :hearts]
    hand << Hands::Card[2, :spades]
    hand << Hands::Card[3, :diamonds]
    hand << Hands::Card[4, :hearts]
    hand << Hands::Card[5, :clubs]
    hand.best_hand[:type].should eq('straight')
  end

  it 'should recognize a straight when ace is high' do
    hand = Hands::Hand.new
    hand << Hands::Card[10, :hearts]
    hand << Hands::Card['J', :spades]
    hand << Hands::Card['Q', :diamonds]
    hand << Hands::Card['K', :hearts]
    hand << Hands::Card['A', :clubs]
    hand.best_hand[:type].should eq('straight')
  end

  it 'should not recognize a straight that wraps around' do
    hand = Hands::Hand.new
    hand << Hands::Card['J', :spades]
    hand << Hands::Card['Q', :diamonds]
    hand << Hands::Card['K', :hearts]
    hand << Hands::Card['A', :clubs]
    hand << Hands::Card[2, :hearts]  
    hand.best_hand[:type].should eq('high_card')
  end
end

describe Hands::Hand, '#flush' do
  it 'should recognize a flush' do
    hand = Hands::Hand.new
    hand << Hands::Card[6, :hearts]
    hand << Hands::Card[7, :hearts]
    hand << Hands::Card[8, :hearts]
    hand << Hands::Card[2, :hearts]
    hand << Hands::Card[4, :hearts]
    hand.best_hand[:type].should eq('flush')
  end
end

describe Hands::Hand, '#full_house' do
  it 'should recognize a full house' do
    hand = Hands::Hand.new
    hand << Hands::Card[7, :hearts]
    hand << Hands::Card[7, :spades]
    hand << Hands::Card[7, :diamonds]
    hand << Hands::Card[9, :spades]
    hand << Hands::Card[9, :clubs]
    hand.best_hand[:type].should eq('full_house')
  end
end

describe Hands::Hand, '#four_of_a_kind' do
  it 'should recognize four of a kind' do
    hand = Hands::Hand.new
    hand << Hands::Card[7, :hearts]
    hand << Hands::Card[7, :spades]
    hand << Hands::Card[7, :diamonds]
    hand << Hands::Card[7, :clubs]
    hand << Hands::Card[9, :clubs]
    hand.best_hand[:type].should eq('four_of_a_kind')
  end
end

describe Hands::Hand, '#straight_flush' do
  it 'should recognize a straight flush' do
    hand = Hands::Hand.new
    hand << Hands::Card[2, :hearts]
    hand << Hands::Card[3, :hearts]
    hand << Hands::Card[4, :hearts]
    hand << Hands::Card[5, :hearts]
    hand << Hands::Card[6, :hearts]
    hand.best_hand[:type].should eq('straight_flush')
  end
end

describe Hands::Hand, '#best_hand' do
  it 'should recognize the best hand'  do
    hand = Hands::Hand.new
    hand << Hands::Card[7, :hearts]
    hand << Hands::Card[7, :spades]
    hand << Hands::Card[4, :diamonds]
    hand << Hands::Card[9, :hearts]
    hand << Hands::Card[9, :clubs]
    hand.best_hand[:type].should eq('two_pair')
  end
end
