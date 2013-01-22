require 'test_helper'

class PlayerTest < Hands::TestCase
  def test_initialization
    player1 = Hands::Player.new
    refute player1.name

    player2 = Hands::Player.new('Sam')
    assert_equal 'Sam', player2.name
  end
end
