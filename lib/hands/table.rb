module Hands
  # Represents a poker table.
  class Table
    # @return [Deck] the {Deck}
    attr_reader :deck

    # @return [Array] {Card}s on the table
    attr_reader :community

    # @return [Array] {Card}s in the muck
    attr_reader :muck

    # @return [Array] {Player}s at the {Table}
    attr_accessor :players

    # Initializes the table with a {Deck}
    def initialize
      @deck = Deck.new
      @community = []
      @muck = []
      @deck.shuffle!
    end

    def deal_player_cards!(number_of_cards = 2)
      number_of_cards.times do
        @players.each do |player|
          player.hand << @deck.pop
        end
      end
    end

    def deal_flop!
      self.burn_card!
      self.turn_cards!(3)
    end

    def deal_turn!
      self.burn_card!
      self.turn_card!
    end

    alias_method :deal_river!, :deal_turn!

    def burn_card!
      @muck << @deck.pop
    end

    def turn_cards!(number_of_cards = 1)
      @community << @deck.pop(number_of_cards)
      @community.flatten!
    end

    alias_method :turn_card!, :turn_cards!

    def new_hand!
      @deck = Deck.new
      @community = []
      @muck = []
      @players.each do |player|
        player.hand.empty!
      end
      @deck.shuffle!
    end
  end
end
