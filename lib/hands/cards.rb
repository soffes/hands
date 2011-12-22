module Hands
  class Card
    attr_accessor :suite
    attr_accessor :value
    
    def value=(val)
      if val > 0 and val <= 10
          @value = val
      elsif val > 10 and val < 15
        @value = VALUES[val - 2]
      else
        @value = nil
      end
    end
    
    def inspect
      if self.is_valid?
        "#{super} #{self.description}"
      else
        super
      end
    end
    
    def is_valid?
      SUITES.include?(self.suite.to_s) and VALUES.include?(self.value.to_s.upcase)
    end
    
    def is_invalid?
      !self.is_valid?      
    end
    
    def description
      if self.is_valid?
        "#{self.value} of #{self.suite.to_s.capitalize}"
      else
        'invalid'
      end      
    end
  end
end
