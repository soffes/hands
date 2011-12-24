module Hands
  # Represents a poker playing card.
  #
  # You can use `Card[]` as a quick initializer. For example,
  # `Card[2, :clubs].description` results in `"Two of Clubs"`.
  class Card
    include Comparable

    # @return [Symbol] Card's suite
    # @see SUITES
    attr_accessor :suite

    # Card's value
    #
    # If an invalid value is set, the value will be set to `nil`.
    # @return [Integer, String] Card's value
    # @see VALUES
    attr_accessor :value

    # (see #initialize)
    def self.[](value = nil, suite = nil)
      self.new(value, suite)
    end

    # Initialize a Card
    #
    # @param [String, Integer, Hash] value If an `Integer` or `String` are provided, this will be set to the value. If a `Hash` is provided, its value for `:value` will be set to the `Card`'s value and its `:suite` value will be set to the `Card`'s suite.
    # @param [Symbol] suite Sets the `Card`'s suite.
    # @return [Card] A new instance of Card
    # @see Card.[]
    def initialize(value = nil, suite = nil)
      # Value provided
      if value.is_a?(Integer) or value.is_a?(String)
        self.value = value

      # Hash provided
      elsif value.is_a?(Hash)
        self.value = value[:value] if value[:value]
        self.suite = value[:suite] if value[:suite]
      end

      # Set suite
      self.suite = suite if suite
    end

    def value=(val)
      # Integer
      if val.is_a?(Integer)
        # Number range
        if val > 0 and val <= 10
          @value = val
          return

        # Face card or ace range
        elsif val > 10 and val < 15
          @value = VALUES[val - 2]
          return
        end

      # String
      elsif val.is_a?(String) and VALUES.include?(val.downcase)
        @value = val.downcase
        return
      end

      # Invalid
      @value = nil
    end

    # Standard inspect
    #
    # @return [String] `super`'s implementation and the receiver's `description` if it `is_valid?`
    def inspect
      if self.is_valid?
        "#{super} #{self.description}"
      else
        super
      end
    end

    # @return [Boolean] Does the receiver contain a valid value and suite combination
    def is_valid?
      SUITES.include?(self.suite.to_s) and VALUES.include?(self.value.to_s.downcase)
    end

    # @return [Boolean] Does the receiver contain an invalid value and suite combination
    def is_invalid?
      !self.is_valid?
    end

    # Get a string representation of the card
    #
    # @return [String] string representation of the card
    def description
      if self.is_valid?
        "#{VALUE_DESCRIPTIONS[self.value_index].capitalize} of #{self.suite.to_s.capitalize}"
      else
        'invalid'
      end
    end

    # Compares the card with another card
    #
    # By default `check_suite` is `false`. If set to `true`, it will order cards that have the same value by their suite.
    #
    # @param [Card] other_card the card to compare the receiver to
    # @param [Boolean] check_suite a boolean indicating if the suite should be accounted for
    # @return [Integer] `-1` if `other_card` is less than the receiver, `0` for equal to, and `1` for greater than
    # @see SUITES
    def <=>(other_card, check_suite = false)
      # TODO: Handle invalid cards
      result = self.value_index <=> other_card.value_index
      return self.suite_index <=> other_card.suite_index if result == 0 and check_suite
      result
    end

    # Suite's index
    #
    # Mainly used for internal reasons when comparing cards.
    #
    # @return [Integer] index of the card's suite
    # @see SUITES
    def suite_index
      SUITES.index(self.suite.to_s.downcase)
    end

    # Values's index
    #
    # Mainly used for internal reasons when comparing cards.
    #
    # @return [Integer] index of the card's value
    # @see VALUES
    def value_index
      VALUES.index(self.value.to_s.downcase)
    end
  end
end
