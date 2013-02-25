module Hands
  # Represents a poker playing card.
  #
  # You can use `Card[]` as a quick initializer. For example,
  # `Card[2, :clubs].description` results in `"Two of Clubs"`.
  class Card
    include Comparable

    # @return [Symbol] Card's suit
    # @see SUITS
    attr_accessor :suit

    # Card's value
    #
    # If an invalid value is set, the value will be set to `nil`.
    # @return [String] Card's value
    # @see VALUES
    attr_accessor :value

    # (see #initialize)
    def self.[](value = nil, suit = nil)
      self.new(value, suit)
    end

    # Initialize a Card
    #
    # @param [String, Integer, Hash] value If an `Integer` or `String` are provided, this will be set to the value. If a `Hash` is provided, its value for `:value` will be set to the `Card`'s value and its `:suit` value will be set to the `Card`'s suit.
    # @param [Symbol] suit Sets the `Card`'s suit.
    # @return [Card] A new instance of Card
    # @see Card.[]
    def initialize(value = nil, suit = nil)
      # Value provided
      if value.is_a?(Integer) or value.is_a?(String)
        self.value = value

      # Hash provided
      elsif value.is_a?(Hash)
        self.value = value[:value] if value[:value]
        self.suit = value[:suit] if value[:suit]
      end

      # Set suit
      self.suit = suit if suit
    end

    def value=(val)
      # Integer
      if val.is_a?(Integer)
        # Number range
        if val > 0 and val <= 10
          @value = val.to_s
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
      raise InvalidValue, "'#{val}' is an invalid suit."
    end

    def suit=(suit)
      # Convert to symbol
      suit = suit.to_sym if suit.is_a?(String)

      # Make sure it's valid
      unless suit.is_a?(Symbol) and SUITS.include?(suit)
        @suit = nil
        raise InvalidSuit, "'#{suit}' is an invalid suit."
      end

      @suit = suit
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

    # @return [Boolean] Does the receiver contain a valid value and suit combination
    def is_valid?
      SUITS.include?(@suit) and VALUES.include?(@value.to_s.downcase)
    end

    # @return [Boolean] Does the receiver contain an invalid value and suit combination
    def is_invalid?
      !self.is_valid?
    end

    # Get a short string representation of the card
    #
    # Example: "♥2"
    #
    # @return [String] short string representation of the card
    def description
      return 'invalid' unless self.is_valid?
      self.value.capitalize + SUIT_CHARACTERS[self.suit_index]
    end

    # Get a string representation of the card
    #
    # Example: "Two of Hearts"
    #
    # @return [String] string representation of the card
    def long_description
      return 'invalid' unless self.is_valid?
      "#{VALUE_DESCRIPTIONS[self.value_index].capitalize} of #{self.suit.to_s.capitalize}"
    end

    # Compares the card with another card
    #
    # By default `check_suit` is `false`. If set to `true`, it will order cards that have the same value by their suit.
    #
    # @param [Card] other_card the card to compare the receiver to
    # @param [Boolean] check_suit a boolean indicating if the suit should be accounted for
    # @return [Integer] `-1` if `other_card` is less than the receiver, `0` for equal to, and `1` for greater than
    # @see SUITS
    def <=>(other_card, check_suit = false)
      # TODO: Handle invalid cards
      result = self.value_index <=> other_card.value_index
      return self.suit_index <=> other_card.suit_index if result == 0 and check_suit
      result
    end

    # Suit's index
    #
    # Mainly used for internal reasons when comparing cards.
    #
    # @return [Integer] index of the card's suit
    # @see SUITS
    def suit_index
      return nil unless self.suit
      SUITS.index(self.suit.downcase)
    end

    # Values's index
    #
    # Mainly used for internal reasons when comparing cards.
    #
    # @return [Integer] index of the card's value
    # @see VALUES
    def value_index
      return nil unless self.value
      VALUES.index(self.value.downcase)
    end
  end
end
