module Hands
  class Card
    include Comparable
    
    attr_accessor :suite
    attr_accessor :value
    
    def initialize(params = nil)
      return unless params
      self.value = params[:value] if params[:value]
      self.suite = params[:suite] if params[:suite]
    end
    
    def value=(val)
      if val.is_a?(Integer)
        if val > 0 and val <= 10
          @value = val
          return
        elsif val > 10 and val < 15
          @value = VALUES[val - 2]
          return
        end
      elsif val.is_a?(String) and VALUES.include?(val.downcase)
        @value = val.downcase
        return
      end
      @value = nil
    end
    
    def inspect
      if self.is_valid?
        "#{super} #{self.description}"
      else
        super
      end
    end
    
    def is_valid?
      SUITES.include?(self.suite.to_s) and VALUES.include?(self.value.to_s.downcase)
    end
    
    def is_invalid?
      !self.is_valid?      
    end
    
    def description
      if self.is_valid?
        "#{VALUE_DESCRIPTIONS[self.value_index].capitalize} of #{self.suite.to_s.capitalize}"
      else
        'invalid'
      end
    end
    
    def <=>(other_card, check_suite = false)
      # TODO: Handle invalid cards
      result = self.value_index <=> other_card.value_index
      return self.suite_index <=> other_card.suite_index if result == 0 and check_suite
      result
    end
    
    protected
    
    def suite_index
      SUITES.index(self.suite.to_s.downcase)
    end
    
    def value_index
      VALUES.index(self.value.to_s.downcase)
    end
  end
end
