require 'hands/hand_detection'

module Hands
  # Represents a poker hand.
  class Hand
    include Comparable
    include HandDetection

    # @return [Array] {Card}s in the {Hand}
    attr_accessor :cards

    def initialize
      @cards = []
    end

    # Compares the {Hand} with another {Hand}.
    #
    # @param [Hand] other_hand the {Hand} to compare the receiver to
    # @return [Integer] `-1` if `other_hand` is less than the receiver, `0` for equal to, and `1` for greater than
    # @see HAND_ORDER
    # @see Card#<=>
    def <=>(other_hand)
      response = (self.hand_index <=> other_hand.hand_index)

      # If the {Hand}s tie, see which is higher (i.e. higher pair)
      if response == 0
        @cards <=> other_hand.cards
      else
        response
      end
    end

    # Add a {Card}
    #
    # @return [Card] the {Card} added
    def <<(card)
      @cards << card
      @cards.flatten! # TODO: Figure out why this is necessary
    end

    # @return [Array] All of the suits contained in the {Hand}
    def suits
      @cards.collect(&:suit).uniq
    end

    # Empties the hand
    def empty!
      @cards = []
    end
  end
end
