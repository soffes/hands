# encoding: UTF-8
require 'test_helper'

class CardTest < Hands::TestCase
  def test_shorthand
    card1 = Hands::Card[4, :hearts]
    card2 = Hands::Card.new(:value => 4, :suit => :hearts)
    assert_equal card1, card2
  end

  def test_that_it_validates_cards
    card = Hands::Card.new
    refute card.is_valid?
    assert card.is_invalid?

    card.suit = :hearts
    refute card.is_valid?

    card.value = 9
    assert card.is_valid?

    assert_raises Hands::InvalidSuit do
      card.suit = 17
    end

    assert_raises Hands::InvalidValue do
      card.value = 19
    end

    card.suit = :hearts
    card.value = 5
    assert card.is_valid?
  end

  def test_that_it_allows_integers_for_high_cards
    card1 = Hands::Card[11, :clubs]
    assert card1.is_valid?
    assert_equal 'j', card1.value

    card2 = Hands::Card['j', :clubs]
    assert_equal card1, card2
  end

  def test_that_its_comparable
    card1 = Hands::Card[2, :hearts]
    card2 = Hands::Card[3, :clubs]

    assert card2 > card1
    assert card1 < card2

    card1.value = 3
    assert card1 == card2
    assert_equal 1, card1.<=>(card2, true)
    assert_equal -1, card2.<=>(card1, true)
  end

  def test_that_it_is_sortable
    c2 = Hands::Card[2, :hearts]
    c3 = Hands::Card[3, :hearts]
    c4 = Hands::Card[4, :hearts]
    c5 = Hands::Card[5, :hearts]
    c6 = Hands::Card[6, :hearts]
    c7 = Hands::Card[7, :hearts]
    c8 = Hands::Card[8, :hearts]
    c9 = Hands::Card[9, :hearts]
    c10 = Hands::Card[10, :hearts]
    cJ = Hands::Card['j', :hearts]
    cQ = Hands::Card['q', :hearts]
    cK = Hands::Card['k', :hearts]
    cA = Hands::Card['a', :hearts]

    cards = [c2, c3, c4, c5, c6, c7, c8, c9, c10, cJ, cQ, cK, cA]
    assert_equal cards, cards.sort
  end

  def test_that_it_includes_the_description_in_inspect
    card = Hands::Card[2, :hearts]
    assert_equal '2♥', card.description
    assert_includes card.inspect, '2♥'
    assert_equal 'Two of Hearts', card.long_description

    card = Hands::Card.new
    assert_equal 'invalid', card.description
    assert_equal 'invalid', card.description
    refute_includes card.inspect, 'invalid'
    assert_equal 'invalid', card.description
  end
end
