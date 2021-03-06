# encoding: UTF-8

require 'hands/version'
require 'hands/card'
require 'hands/hand'
require 'hands/player'
require 'hands/deck'
require 'hands/table'

# See <http://www.pagat.com/poker/rules/ranking.html> for ranking references.
module Hands
  # All card values
  VALUES = %w{2 3 4 5 6 7 8 9 10 j q k a}

  # All card value descriptions
  VALUE_DESCRIPTIONS = %w{two three four five six seven eight nine ten jack queen king ace}

  # Alphabetically ordered suits (higher index in the array is higher value)
  SUITS = [:clubs, :diamonds, :hearts, :spades]
  SUIT_CHARACTERS = %w{♣ ♦ ♥ ♠}

  # Ranks of poker hands
  HAND_ORDER = [
    :high_card, :pair, :two_pair, :three_of_a_kind, :straight, :flush, :full_house,
    :four_of_a_kind, :straight_flush, :royal_flush
  ]

  # Raised when an invalid suit is used
  class InvalidSuit < StandardError; end

  # Raised when an invalid value is used
  class InvalidValue < StandardError; end
end
