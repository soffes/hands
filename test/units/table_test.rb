require 'test_helper'

class TableTest < Hands::TestCase
  def setup
    @sam = Hands::Player.new('Sam')
    @ian = Hands::Player.new('Ian')
    @steve = Hands::Player.new('Steve')

    @table = Hands::Table.new
    @table.players = [@sam, @ian, @steve]
  end

  def test_dealing
    @table.deal_player_cards!
    assert_equal 2, @sam.hand.cards.length
    assert_equal 2, @ian.hand.cards.length
    assert_equal 2, @steve.hand.cards.length
    assert_equal 46, @table.deck.cards.length
  end

  def test_dealing_with_position
    cards = @table.deck.cards.dup
    @table.deal_player_cards!
    assert_equal [cards.slice(-3, 1), cards.slice(-6, 1)].flatten, @sam.hand.cards
    assert_equal [cards.slice(-1, 1), cards.slice(-4, 1)].flatten, @ian.hand.cards
    assert_equal [cards.slice(-2, 1), cards.slice(-5, 1)].flatten, @steve.hand.cards

    @table.new_hand!
    cards = @table.deck.cards.dup
    @table.deal_player_cards!
    assert_equal [cards.slice(-2, 1), cards.slice(-5, 1)].flatten, @sam.hand.cards
    assert_equal [cards.slice(-3, 1), cards.slice(-6, 1)].flatten, @ian.hand.cards
    assert_equal [cards.slice(-1, 1), cards.slice(-4, 1)].flatten, @steve.hand.cards

    @table.new_hand!
    cards = @table.deck.cards.dup
    @table.deal_player_cards!
    assert_equal [cards.slice(-1, 1), cards.slice(-4, 1)].flatten, @sam.hand.cards
    assert_equal [cards.slice(-2, 1), cards.slice(-5, 1)].flatten, @ian.hand.cards
    assert_equal [cards.slice(-3, 1), cards.slice(-6, 1)].flatten, @steve.hand.cards
  end

  def test_dealing_the_flop
    @table.deal_player_cards!
    @table.deal_flop!
    assert_equal 42, @table.deck.cards.length
  end

  def test_dealing_the_turn
    @table.deal_player_cards!
    @table.deal_flop!
    @table.deal_turn!
    assert_equal 40, @table.deck.cards.length
  end

  def test_dealing_the_river
    @table.deal_player_cards!
    @table.deal_flop!
    @table.deal_turn!
    @table.deal_river!
    assert_equal 38, @table.deck.cards.length
  end

  def test_resetting
    @table.deal_player_cards!
    @table.deal_flop!
    @table.deal_turn!
    @table.deal_river!
    @table.new_hand!
    assert_equal 0, @sam.hand.cards.length
    assert_equal 0, @ian.hand.cards.length
    assert_equal 0, @steve.hand.cards.length
    assert_equal 52, @table.deck.cards.length
  end
end
