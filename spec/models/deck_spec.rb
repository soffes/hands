require 'spec_helper'

describe Hands::Deck do
  describe '#shuffle!' do
    it 'should shuffle' do
      deck = Hands::Deck.new
      cards = deck.cards.collect(&:description)
      deck.shuffle!
      deck.cards.collect(&:description).should_not eq(cards)
    end
  end

  describe '#pop' do
    it 'should pop a card' do
      deck = Hands::Deck.new
      card = deck.pop
      deck.cards.include?(card).should be_false
    end
  end
end
