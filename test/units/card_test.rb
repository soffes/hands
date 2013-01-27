# encoding: UTF-8
require 'test_helper'

class CardTest < Hands::TestCase
  def test_that_it_validates_cards
    card = Hands::Card.new
    refute card.is_valid?
    assert card.is_invalid?

    card.suit = :hearts
    refute card.is_valid?

    card.value = 9
    assert card.is_valid?

    card.suit = 17
    refute card.is_valid?

    card.suit = :hearts
    card.value = 19
    refute card.is_valid?
  end

  def test_that_it_allows_integers_for_high_cards
    card1 = Hands::Card.new(value: 11, suit: :clubs)
    assert card1.is_valid?
    assert_equal 'j', card1.value

    card2 = Hands::Card.new(value: 'j', suit: :clubs)
    assert_equal card1, card2
  end

  def test_that_its_comparable
    card1 = Hands::Card.new(value: 2, suit: :hearts)
    card2 = Hands::Card.new(value: 3, suit: :clubs)

    assert card2 > card1
    assert card1 < card2

    card1.value = 3
    assert card1 == card2
    assert_equal 1, card1.<=>(card2, true)
    assert_equal -1, card2.<=>(card1, true)
  end

  def test_that_it_is_sortable
    c2 = Hands::Card.new(value: 2, suit: :hearts)
    c3 = Hands::Card.new(value: 3, suit: :hearts)
    c4 = Hands::Card.new(value: 4, suit: :hearts)
    c5 = Hands::Card.new(value: 5, suit: :hearts)
    c6 = Hands::Card.new(value: 6, suit: :hearts)
    c7 = Hands::Card.new(value: 7, suit: :hearts)
    c8 = Hands::Card.new(value: 8, suit: :hearts)
    c9 = Hands::Card.new(value: 9, suit: :hearts)
    c10 = Hands::Card.new(value: 10, suit: :hearts)
    cJ = Hands::Card.new(value: 'j', suit: :hearts)
    cQ = Hands::Card.new(value: 'q', suit: :hearts)
    cK = Hands::Card.new(value: 'k', suit: :hearts)
    cA = Hands::Card.new(value: 'a', suit: :hearts)

    cards = [c2, c3, c4, c5, c6, c7, c8, c9, c10, cJ, cQ, cK, cA]
    assert_equal cards, cards.sort
  end

  def test_that_it_includes_the_description_in_inspect
    card = Hands::Card.new(value: 2, suit: :hearts)
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
