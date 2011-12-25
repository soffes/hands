require 'spec_helper'

describe Hands::Player, '#initialize' do
  it 'should be initialized with a name' do
    player1 = Hands::Player.new
    player1.name.should be_nil

    player2 = Hands::Player.new('Sam')
    player2.name.should eq('Sam')
  end
end
