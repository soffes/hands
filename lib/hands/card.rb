module Hands
  class Card
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
        "#{VALUE_DESCRIPTIONS[VALUES.index(self.value.to_s)].capitalize} of #{self.suite.to_s.capitalize}"
      else
        'invalid'
      end
    end
  end
end
