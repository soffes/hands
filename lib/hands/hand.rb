module Hands
  class Hand
    include Comparable

    attr_accessor :cards

    def cards
      @cards ||= []
    end
        
    def <=>(other_hand)
      response = (self.hand_index <=> other_hand.hand_index)

      # If the hands tie, see which is higher (i.e. higher pair)
      if response == 0
        self.cards <=> other_hand.cards
      else
        response
      end
    end

    def <<(card)
      self.cards << card
    end

    def suites
      self.cards.collect(&:suite).uniq
    end

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

    def high_card
      self.cards.sort.reverse
    end

    def pair
      self.pairs(1)
    end

    def two_pair
      self.pairs(2)
    end

    def three_of_a_kind
      nil
    end

    def straight
      return nil unless self.cards.length == 5
      cs = self.cards.sort.reverse

      # Ace's low
      if cs.first.value == 'a' and cs[1].value == 5
        # Move ace to end
        ace = cs.first
        cs = cs[1..4]
        cs << ace

        # Check succession
        csr = cs.reverse
        4.times do |i|
          next if i == 0
          return nil unless csr[i].value_index == i - 1
        end

      # Normal
      else
        # Check range
        return nil unless cs.first.value_index - cs.last.value_index == 4

        # Check succession
        4.times do |i|        
          return nil unless cs[i].value_index == cs[i + 1].value_index + 1
        end
      end
      cs
    end
    
    def flush
      # If all of the cards are the same suite, we have a flush
      return nil unless self.suites.length == 1
      self.cards.sort.reverse
    end
    
    def full_house
      # TODO: Implement
      nil
    end
    
    def four_of_a_kind
      # TODO: Implement
      nil
    end
    
    def straight_flush
      # TODO: Implement
      nil
    end
    
    protected

    def hand_index
      best = self.best_hand
      return -1 if best.nil?
      HAND_ORDER.index(best[:type].to_s)
    end

    def duplicates
      pairs = self.cards.collect(&:value)
      pairs.uniq.select{ |e| (pairs - [e]).size < pairs.size - 1 }
    end

    def pairs(min)
      dupes = self.duplicates
      return nil if dupes.length < min

      hand = self.cards.select do |card|
        dupes.include?(card.value)
      end

      hand = hand.sort.reverse
      hand << (self.cards - hand).sort.reverse
      hand.flatten
    end
  end
end
