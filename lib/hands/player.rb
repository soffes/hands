module Hands
  class Player
    # @return [String] Their name
    attr_accessor :name

    # @return [Hand] Their hand
    attr_accessor :hand

    # @return [Table] The {Table} they are sitting at
    attr_accessor :table

    # Initialize a new {Player}
    # @param [String] name {Player}'s name
    def initialize(name = nil)
      @hand = Hand.new
      self.name = name if name
    end
  end
end
