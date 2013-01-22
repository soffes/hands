require 'test_helper'

class DeckTest < Hands::TestCase
  def test_shuffle
    deck = Hands::Deck.new
    cards = deck.cards.collect(&:description)
    deck.shuffle!
    refute_equal cards, deck.cards.collect(&:description)
  end

  def test_popping
    deck = Hands::Deck.new
    card = deck.pop
    refute_includes deck.cards, card
  end
end
