require 'test_helper'

class HandTest < Hands::TestCase
  def test_ordering_hands
    pair = Hands::Hand.new
    pair << Hands::Card[2, :hearts]
    pair << Hands::Card[2, :clubs]

    flush = Hands::Hand.new
    flush << Hands::Card[6, :hearts]
    flush << Hands::Card[7, :hearts]
    flush << Hands::Card[8, :hearts]
    flush << Hands::Card[2, :hearts]
    flush << Hands::Card[4, :hearts]
    assert flush > pair
  end

  def test_order_same_hand
    small_pair = Hands::Hand.new
    small_pair << Hands::Card[2, :hearts]
    small_pair << Hands::Card[2, :clubs]

    large_pair = Hands::Hand.new
    large_pair << Hands::Card['A', :hearts]
    large_pair << Hands::Card['A', :clubs]
    assert large_pair > small_pair

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
    assert big_kicker > small_kicker
  end

  def test_collecting_suits
    hand = Hands::Hand.new
    hand << Hands::Card[2, :hearts]
    hand << Hands::Card[2, :clubs]
    assert_equal [:hearts, :clubs], hand.suites

    hand << Hands::Card[3, :clubs]
    assert_equal [:hearts, :clubs], hand.suites
  end
end
