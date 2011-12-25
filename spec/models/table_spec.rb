require 'spec_helper'

describe Hands::Table, '#deal_player_cards!' do
  it 'should deal cards to players' do
    sam = Hands::Player.new('Sam')
    ian = Hands::Player.new('Ian')

    table = Hands::Table.new
    table.players = [sam, ian]

    table.deal_player_cards!
    sam.hand.cards.length.should eq(2)
    ian.hand.cards.length.should eq(2)
    table.deck.cards.length.should eq(48)
  end
end
