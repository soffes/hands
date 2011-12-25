require 'spec_helper'

describe Hands::Table do
  before(:each) do
    @sam = Hands::Player.new('Sam')
    @ian = Hands::Player.new('Ian')

    @table = Hands::Table.new
    @table.players = [@sam, @ian]
  end

  describe '#deal_player_cards!' do
    it 'should deal cards to players' do
      @table.deal_player_cards!
      @sam.hand.cards.length.should eq(2)
      @ian.hand.cards.length.should eq(2)
      @table.deck.cards.length.should eq(48)
    end
  end

  describe '#deal_flop!' do
    it 'should deal the flop' do
      @table.deal_player_cards!
      @table.deal_flop!
      @table.deck.cards.length.should eq(44)
    end
  end

  describe '#deal_turn!' do
    it 'should deal the turn' do
      @table.deal_player_cards!
      @table.deal_flop!
      @table.deal_turn!
      @table.deck.cards.length.should eq(42)
    end
  end

  describe '#deal_river!' do
    it 'should deal the river' do
      @table.deal_player_cards!
      @table.deal_flop!
      @table.deal_turn!
      @table.deal_river!
      @table.deck.cards.length.should eq(40)
    end
  end

  describe '#new_hand!' do
    it 'should reset everything for a new hand' do
      @table.deal_player_cards!
      @table.deal_flop!
      @table.deal_turn!
      @table.deal_river!
      @table.new_hand!
      @sam.hand.cards.length.should eq(0)
      @ian.hand.cards.length.should eq(0)
      @table.deck.cards.length.should eq(52)
    end
  end
end
