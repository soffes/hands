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
    
    
    def high_card
      self.cards.sort
    end
  end
end
