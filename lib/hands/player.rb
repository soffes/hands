module Hands
  class Player
    # @return [String] Their name
    attr_accessor :name

    # @return [Hand] Their hand
    attr_accessor :hand

    # Initialize a new {Player}
    # @param [String] name {Player}'s name
    def initialize(name = nil)
      @hand = Hand.new
      self.name = name if name
    end
  end
end
