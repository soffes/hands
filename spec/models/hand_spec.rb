require 'spec_helper'

describe Hands::Hand do
  describe '#<=>' do
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

  describe '#suites' do
    it 'should collect suites' do
      hand = Hands::Hand.new
      hand << Hands::Card[2, :hearts]
      hand << Hands::Card[2, :clubs]
      hand.suites.should eq([:hearts, :clubs])

      hand << Hands::Card[3, :clubs]
      hand.suites.should eq([:hearts, :clubs])
    end
  end
end
