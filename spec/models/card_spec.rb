require 'spec_helper'

describe Hands::Card, '#is_valid?' do
  it 'should validate cards' do
    card = Hands::Card.new
    card.is_valid?.should be_false
    card.is_invalid?.should be_true

    card.suite = :hearts
    card.is_valid?.should be_false

    card.value = 9
    card.is_valid?.should be_true

    card.suite = 17
    card.is_valid?.should be_false
  end

  it 'should allow for integers instead of characters for high cards' do
    card1 = Hands::Card.new(:value => 11, :suite => :clubs)
    card1.is_valid?.should be_true
    card1.value.should eq('j')

    card2 = Hands::Card.new(:value => 'j', :suite => :clubs)
    card2.should eq(card1)
  end

  it 'should not allow invalid values' do
    card = Hands::Card.new
    card.value = 'p'
    card.value.should eq(nil)
  end
end

describe Hands::Card, '#<=>' do
  it 'should be comparable' do
    card1 = Hands::Card.new(:value => 2, :suite => :hearts)
    card2 = Hands::Card.new(:value => 3, :suite => :clubs)

    (card2 > card1).should be_true
    (card1 < card2).should be_true

    card1.value = 3
    (card1 == card2).should be_true
    (card1.<=>(card2, true)).should eq(1)
    (card2.<=>(card1, true)).should eq(-1)
  end

  it 'should be sortable' do
    c2 = Hands::Card.new(:value => 2, :suite => :hearts)
    c3 = Hands::Card.new(:value => 3, :suite => :hearts)
    c4 = Hands::Card.new(:value => 4, :suite => :hearts)
    c5 = Hands::Card.new(:value => 5, :suite => :hearts)
    c6 = Hands::Card.new(:value => 6, :suite => :hearts)
    c7 = Hands::Card.new(:value => 7, :suite => :hearts)
    c8 = Hands::Card.new(:value => 8, :suite => :hearts)
    c9 = Hands::Card.new(:value => 9, :suite => :hearts)
    c10 = Hands::Card.new(:value => 10, :suite => :hearts)
    cJ = Hands::Card.new(:value => 'j', :suite => :hearts)
    cQ = Hands::Card.new(:value => 'q', :suite => :hearts)
    cK = Hands::Card.new(:value => 'k', :suite => :hearts)
    cA = Hands::Card.new(:value => 'a', :suite => :hearts)

    cards = [c2, c3, c4, c5, c6, c7, c8, c9, c10, cJ, cQ, cK, cA]
    cards.sort.should eq(cards)    
  end
end

describe Hands::Card, '#description' do
  it 'should include description in inspect' do
    card = Hands::Card[2, :hearts]
    card.inspect.include?('Two of Hearts').should be_true

    card = Hands::Card.new
    card.description.should eq('invalid')
    card.inspect.include?('invalid').should be_false
  end
end
