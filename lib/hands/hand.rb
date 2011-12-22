module Hands
  class Hand
    include Comparable
    
    attr_accessor :cards
    
    def cards
      @cards ||= []
    end
        
    def <=>(other_hand)
      0
    end
    
    def <<(card)
      self.cards << card
    end
    
    def suites
      self.cards.collect(&:suite).uniq
    end
    
    def duplicates
      pairs = self.cards.collect(&:value)
      pairs.uniq.select{ |e| (pairs - [e]).size < pairs.size - 1 }
    end
    
    # Hands
    
    def high_card
      self.cards.sort.reverse
    end
    
    def pair
      dupes = self.duplicates
      return nil if dupes.length == 0
      
      hand = self.cards.select do |card|
        dupes.include?(card.value)
      end
      
      hand = hand.sort.reverse
      hand << (self.cards - hand).sort.reverse
      hand.flatten
    end
    
    def two_pair
      dupes = self.duplicates
      return nil if dupes.length < 2
      
      hand = self.cards.select do |card|
        dupes.include?(card.value)
      end
      
      hand = hand.sort.reverse
      hand << (self.cards - hand).sort.reverse
      hand.flatten
    end
  end
end
