require 'test_helper'

class CardTest < Hands::TestCase
  def test_that_it_validates_cards
    card = Hands::Card.new
    refute card.is_valid?
    assert card.is_invalid?

    card.suite = :hearts
    refute card.is_valid?

    card.value = 9
    assert card.is_valid?

    card.suite = 17
    refute card.is_valid?

    card.suite = :hearts
    card.value = 19
    refute card.is_valid?
  end

  def test_that_it_allows_integers_for_high_cards
    card1 = Hands::Card.new(value: 11, suite: :clubs)
    assert card1.is_valid?
    assert_equal 'j', card1.value

    card2 = Hands::Card.new(value: 'j', suite: :clubs)
    assert_equal card1, card2
  end

  def test_that_its_comparable
    card1 = Hands::Card.new(value: 2, suite: :hearts)
    card2 = Hands::Card.new(value: 3, suite: :clubs)

    assert card2 > card1
    assert card1 < card2

    card1.value = 3
    assert card1 == card2
    assert_equal 1, card1.<=>(card2, true)
    assert_equal -1, card2.<=>(card1, true)
  end

  def test_that_it_is_sortable
    c2 = Hands::Card.new(value: 2, suite: :hearts)
    c3 = Hands::Card.new(value: 3, suite: :hearts)
    c4 = Hands::Card.new(value: 4, suite: :hearts)
    c5 = Hands::Card.new(value: 5, suite: :hearts)
    c6 = Hands::Card.new(value: 6, suite: :hearts)
    c7 = Hands::Card.new(value: 7, suite: :hearts)
    c8 = Hands::Card.new(value: 8, suite: :hearts)
    c9 = Hands::Card.new(value: 9, suite: :hearts)
    c10 = Hands::Card.new(value: 10, suite: :hearts)
    cJ = Hands::Card.new(value: 'j', suite: :hearts)
    cQ = Hands::Card.new(value: 'q', suite: :hearts)
    cK = Hands::Card.new(value: 'k', suite: :hearts)
    cA = Hands::Card.new(value: 'a', suite: :hearts)

    cards = [c2, c3, c4, c5, c6, c7, c8, c9, c10, cJ, cQ, cK, cA]
    assert_equal cards, cards.sort
  end

  def test_that_it_includes_the_description_in_inspect
    card = Hands::Card.new(value: 2, suite: :hearts)
    assert_includes card.inspect, 'Two of Hearts'

    card = Hands::Card.new
    assert_equal 'invalid', card.description
    refute_includes card.inspect, 'invalid'
  end
end
