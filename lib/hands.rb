require 'hands/version'
require 'hands/card'
require 'hands/hand'

module Hands
  VALUES = %w{ 2 3 4 5 6 7 8 9 10 j q k a }
  VALUE_DESCRIPTIONS = %w{ two three four five six seven eight nine ten jack queen king ace }

  # Reference: http://www.pagat.com/poker/rules/ranking.html
  SUITES = %w{ clubs diamonds hearts spades } # Reverse alphabetical
  HAND_ORDER = %w{ high_card pair two_pair three_of_a_kind straight flush full_house four_of_a_kind straight_flush }
end
