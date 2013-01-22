require 'test_helper'

class HandDetectionTest < Hands::TestCase

  def test_best_hand
    hand = Hands::Hand.new
    hand << Hands::Card[7, :hearts]
    hand << Hands::Card[7, :spades]
    hand << Hands::Card[4, :diamonds]
    hand << Hands::Card[9, :hearts]
    hand << Hands::Card[9, :clubs]
    assert_equal :two_pair, hand.best_hand[:type]
  end


  #### High Card

  def test_high_card
    hand = Hands::Hand.new
    hand << Hands::Card[2, :hearts]
    hand << Hands::Card[9, :clubs]
    hand << Hands::Card[7, :hearts]
    hand << Hands::Card['a', :spades]
    hand << Hands::Card[4, :diamonds]
    assert_equal %w{a 9 7 4 2}, hand.high_card.collect(&:value)
    refute hand.pair
    refute hand.two_pair
  end


  #### Pair

  def test_pair
    hand = Hands::Hand.new
    hand << Hands::Card[9, :hearts]
    hand << Hands::Card[9, :clubs]
    hand << Hands::Card[7, :hearts]
    hand << Hands::Card[2, :spades]
    hand << Hands::Card[4, :diamonds]
    assert_equal %w{9 9 7 4 2}, hand.pair.collect(&:value)
    refute hand.two_pair
  end


  #### Two Pair

  def test_two_pair
    hand = Hands::Hand.new
    hand << Hands::Card[7, :hearts]
    hand << Hands::Card[7, :spades]
    hand << Hands::Card[4, :diamonds]
    hand << Hands::Card[9, :hearts]
    hand << Hands::Card[9, :clubs]
    assert_equal %w{9 9 7 7 4}, hand.two_pair.collect(&:value)
    assert_equal hand.pair, hand.two_pair
  end


  #### Three of a Kind

  def test_three_of_a_kind
    hand = Hands::Hand.new
    hand << Hands::Card[7, :hearts]
    hand << Hands::Card[7, :spades]
    hand << Hands::Card[7, :diamonds]
    hand << Hands::Card[3, :hearts]
    hand << Hands::Card[9, :clubs]
    assert_equal :three_of_a_kind, hand.best_hand[:type]
  end


  #### Straight

  def test_straight
    hand = Hands::Hand.new
    hand << Hands::Card[2, :hearts]
    hand << Hands::Card[3, :spades]
    hand << Hands::Card[4, :diamonds]
    hand << Hands::Card[5, :hearts]
    hand << Hands::Card[6, :clubs]
    assert_equal :straight, hand.best_hand[:type]
  end

  def test_straight_when_ace_is_low
    hand = Hands::Hand.new
    hand << Hands::Card['A', :hearts]
    hand << Hands::Card[2, :spades]
    hand << Hands::Card[3, :diamonds]
    hand << Hands::Card[4, :hearts]
    hand << Hands::Card[5, :clubs]
    assert_equal :straight, hand.best_hand[:type]
  end

  def test_straight_when_ace_is_high
    hand = Hands::Hand.new
    hand << Hands::Card[10, :hearts]
    hand << Hands::Card['J', :spades]
    hand << Hands::Card['Q', :diamonds]
    hand << Hands::Card['K', :hearts]
    hand << Hands::Card['A', :clubs]
    assert_equal :straight, hand.best_hand[:type]
  end

  def test_straights_dont_wrap_around
    hand = Hands::Hand.new
    hand << Hands::Card['J', :spades]
    hand << Hands::Card['Q', :diamonds]
    hand << Hands::Card['K', :hearts]
    hand << Hands::Card['A', :clubs]
    hand << Hands::Card[2, :hearts]
    assert_equal :high_card, hand.best_hand[:type]
  end


  #### Flush

  def test_flush
    hand = Hands::Hand.new
    hand << Hands::Card[6, :hearts]
    hand << Hands::Card[7, :hearts]
    hand << Hands::Card[8, :hearts]
    hand << Hands::Card[2, :hearts]
    hand << Hands::Card[4, :hearts]
    assert_equal :flush, hand.best_hand[:type]
  end


  #### Full House

  def test_full_house
    hand = Hands::Hand.new
    hand << Hands::Card[7, :hearts]
    hand << Hands::Card[7, :spades]
    hand << Hands::Card[7, :diamonds]
    hand << Hands::Card[9, :spades]
    hand << Hands::Card[9, :clubs]
    assert_equal :full_house, hand.best_hand[:type]
  end


  #### Four of a Kind

  def test_four_of_a_kind
    hand = Hands::Hand.new
    hand << Hands::Card[7, :hearts]
    hand << Hands::Card[7, :spades]
    hand << Hands::Card[7, :diamonds]
    hand << Hands::Card[7, :clubs]
    hand << Hands::Card[9, :clubs]
    assert_equal :four_of_a_kind, hand.best_hand[:type]
  end


  #### Straight Flush

  def test_straight_flush
    hand = Hands::Hand.new
    hand << Hands::Card[2, :hearts]
    hand << Hands::Card[3, :hearts]
    hand << Hands::Card[4, :hearts]
    hand << Hands::Card[5, :hearts]
    hand << Hands::Card[6, :hearts]
    assert_equal :straight_flush, hand.best_hand[:type]
  end


  #### Royal Flush

  def test_royal_flush
    hand = Hands::Hand.new
    hand << Hands::Card[10, :hearts]
    hand << Hands::Card['j', :hearts]
    hand << Hands::Card['q', :hearts]
    hand << Hands::Card['k', :hearts]
    hand << Hands::Card['a', :hearts]
    assert_equal :royal_flush, hand.best_hand[:type]
  end
end
