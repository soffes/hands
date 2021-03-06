module Hands
  module HandDetection
    # @return [Hash] A hash with `:type` and `:cards` keys.
    def best_hand
      response = {}
      HAND_ORDER.reverse.each do |type|
        cards = self.send(type.to_sym)
        next unless cards
        response[:type] = type
        response[:cards] = cards
        break
      end
      response
    end

    # @return [Array] Array of {Card} objects with the highest {Card} first
    def high_card
      self.cards.sort.reverse
    end

    # @return [Array, Nil] Array of {Card} objects with the pair first and kickers in decending order or `nil` if there isn't a pair in the {Hand}
    def pair
      self.pairs(1)
    end

    # @return [Array, Nil] Array of {Card} objects with the pairs first and kickers in decending order or `nil` if there isn't two pair in the {Hand}
    def two_pair
      self.pairs(2)
    end

    # @return [Array, Nil] Array of {Card} objects with the three of a kind first and kickers in decending order or `nil` if there isn't three of a kind in the {Hand}
    def three_of_a_kind
      self.kinds(3)
    end

    # @return [Array, Nil] Array of {Card} objects with the straight in decending order or `nil` if there isn't a straight in the {Hand}
    def straight
      # Require at least 5 cards
      return nil unless self.cards.length >= 5
      
      # Sort
      cs = self.cards.sort.reverse

      # Ace's low
      return cs if cs.first.value == 'a' and cs[1].value == '5'

      # Check succession
      return nil unless succession?

      # Avoid wrap-around
      values = self.cards.collect(&:value)
      return nil if values.include?('k') and values.include?(2)

      cs
    end

    # @return [Array, Nil] Array of {Card} objects with the flush in decending order or `nil` if there isn't a flush in the {Hand}
    def flush
      # If all of the {Card}s are the same suit, we have a flush
      return nil unless self.cards.length >= 5 and self.suits.length == 1
      self.cards.sort.reverse
    end

    # @return [Array, Nil] Array of {Card} objects with the full house in decending order or `nil` if there isn't a full house in the {Hand}
    def full_house
      dupes = self.duplicates
      return nil unless self.cards.length >= 5 and dupes.length == 2
      
      # Ensure all {Card}s are one of the duplicates
      self.cards.each do |card|
        return nil unless dupes.include? card.value
      end

      self.cards.sort.reverse
    end

    # @return [Array, Nil] Array of {Card} objects with the four of a kind first the kicker in decending order or `nil` if there isn't four of a kind in the {Hand}
    def four_of_a_kind
      self.kinds(4)
    end

    # @return [Array, Nil] Array of {Card} objects with the straight flush in decending order or `nil` if there isn't a straight flush in the {Hand}
    def straight_flush
      return nil unless self.flush
      self.straight
    end

    # @return [Array, Nil] Array of {Card} objects with the royal flush in decending order or `nil` if there isn't a straight flush in the {Hand}
    def royal_flush
      # Require a straight flush first
      sf = self.straight_flush
      return nil unless sf

      # Make sure the highest card is an ace
      return nil unless sf.first.value == 'a'

      sf
    end

    # Hand's index
    #
    # Mainly used for internal reasons when comparing {Hand}.
    #
    # @return [Integer] index of the {Hand}'s rank
    # @see HAND_ORDER
    def hand_index
      best = self.best_hand
      return -1 if best.nil?
      HAND_ORDER.index(best[:type].to_s)
    end

  protected

    def duplicates
      pairs = self.cards.collect(&:value)
      pairs.uniq.select{ |e| (pairs - [e]).size < pairs.size - 1 }
    end

    def pairs(min)
      dupes = self.duplicates
      return nil unless dupes.length >= min

      hand = self.cards.select do |card|
        dupes.include?(card.value)
      end

      hand = hand.sort.reverse
      hand << (self.cards - hand).sort.reverse
      hand.flatten
    end

    def kinds(num)
      dupes = self.duplicates
      return nil unless dupes.length == 1

      hand = self.cards.select do |card|
        dupes.include?(card.value)
      end

      return nil unless hand.length == num

      hand = hand.sort.reverse
      hand << (self.cards - hand).sort.reverse
      hand.flatten
    end
    
    def succession?
      cs = self.cards.sort.reverse
      4.times do |i|
        return false unless cs[i].value_index == cs[i + 1].value_index + 1
      end
      true
    end
  end
end
