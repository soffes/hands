module Hands
  class Deck
    # @return [Array] {Card}s in the {Deck}
    attr_reader :cards

    # Initialize the deck with 52 {Card}s
    def initialize
      @cards = []
      VALUES.each do |value|
        SUITES.each do |suite|
          @cards << Card[value, suite]
        end
      end
    end

    # Shuffle the {Deck}
    def shuffle!
      @cards.shuffle!
    end

    # Pop a card off the {Deck}
    # @return [Card] the {Card}(s) popped off the {Deck}
    def pop(number_of_cards = 1)
      @cards.pop(number_of_cards)
    end
  end
end
