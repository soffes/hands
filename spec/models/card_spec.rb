require 'spec_helper'

describe Hands::Card do
  it 'should validate cards' do
    card = Hands::Card.new
    card.is_valid?.should eq(false)
    card.is_invalid?.should eq(true)
    
    card.suite = :hearts
    card.is_valid?.should eq(false)
    
    card.value = 9
    card.is_valid?.should eq(true)
    
    card.suite = 17
    card.is_valid?.should eq(false)
  end
  
  it 'should allow for integers instead of characters for high cards' do
    card = Hands::Card.new
    card.suite = :clubs
    card.value = 11
    
    card.is_valid?.should eq(true)
    card.value.should eq('J')
  end
end
