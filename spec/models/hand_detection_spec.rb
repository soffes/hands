describe Hands::Hand do
  describe '#high_card' do
    it 'should recognize high card' do
      hand = Hands::Hand.new
      hand << Hands::Card[2, :hearts]
      hand << Hands::Card[9, :clubs]
      hand << Hands::Card[7, :hearts]
      hand << Hands::Card['a', :spades]
      hand << Hands::Card[4, :diamonds]
      hand.high_card.collect(&:value).should eq(%w{a 9 7 4 2})
      hand.pair.should eq(nil)
      hand.two_pair.should eq(nil)
    end
  end

  describe '#pair' do
    it 'should recognize a pair' do
      hand = Hands::Hand.new
      hand << Hands::Card[9, :hearts]
      hand << Hands::Card[9, :clubs]
      hand << Hands::Card[7, :hearts]
      hand << Hands::Card[2, :spades]
      hand << Hands::Card[4, :diamonds]
      hand.pair.collect(&:value).should eq(%w{9 9 7 4 2})
      hand.two_pair.should eq(nil)
    end
  end

  describe '#two_pair' do
    it 'should recognize two pair'  do
      hand = Hands::Hand.new
      hand << Hands::Card[7, :hearts]
      hand << Hands::Card[7, :spades]
      hand << Hands::Card[4, :diamonds]
      hand << Hands::Card[9, :hearts]
      hand << Hands::Card[9, :clubs]
      hand.two_pair.collect(&:value).should eq(%w{9 9 7 7 4})
      hand.two_pair.should eq(hand.pair)
    end
  end

  describe '#three_of_a_kind' do
    it 'should recognize three of a kind' do
      hand = Hands::Hand.new
      hand << Hands::Card[7, :hearts]
      hand << Hands::Card[7, :spades]
      hand << Hands::Card[7, :diamonds]
      hand << Hands::Card[3, :hearts]
      hand << Hands::Card[9, :clubs]
      hand.best_hand[:type].should eq('three_of_a_kind')
    end
  end

  describe '#straight' do
    it 'should recognize a straight' do
      hand = Hands::Hand.new
      hand << Hands::Card[2, :hearts]
      hand << Hands::Card[3, :spades]
      hand << Hands::Card[4, :diamonds]
      hand << Hands::Card[5, :hearts]
      hand << Hands::Card[6, :clubs]
      hand.best_hand[:type].should eq('straight')
    end

    it 'should recognize a straight when ace is low' do
      hand = Hands::Hand.new
      hand << Hands::Card['A', :hearts]
      hand << Hands::Card[2, :spades]
      hand << Hands::Card[3, :diamonds]
      hand << Hands::Card[4, :hearts]
      hand << Hands::Card[5, :clubs]
      hand.best_hand[:type].should eq('straight')
    end

    it 'should recognize a straight when ace is high' do
      hand = Hands::Hand.new
      hand << Hands::Card[10, :hearts]
      hand << Hands::Card['J', :spades]
      hand << Hands::Card['Q', :diamonds]
      hand << Hands::Card['K', :hearts]
      hand << Hands::Card['A', :clubs]
      hand.best_hand[:type].should eq('straight')
    end

    it 'should not recognize a straight that wraps around' do
      hand = Hands::Hand.new
      hand << Hands::Card['J', :spades]
      hand << Hands::Card['Q', :diamonds]
      hand << Hands::Card['K', :hearts]
      hand << Hands::Card['A', :clubs]
      hand << Hands::Card[2, :hearts]  
      hand.best_hand[:type].should eq('high_card')
    end
  end

  describe '#flush' do
    it 'should recognize a flush' do
      hand = Hands::Hand.new
      hand << Hands::Card[6, :hearts]
      hand << Hands::Card[7, :hearts]
      hand << Hands::Card[8, :hearts]
      hand << Hands::Card[2, :hearts]
      hand << Hands::Card[4, :hearts]
      hand.best_hand[:type].should eq('flush')
    end
  end

  describe '#full_house' do
    it 'should recognize a full house' do
      hand = Hands::Hand.new
      hand << Hands::Card[7, :hearts]
      hand << Hands::Card[7, :spades]
      hand << Hands::Card[7, :diamonds]
      hand << Hands::Card[9, :spades]
      hand << Hands::Card[9, :clubs]
      hand.best_hand[:type].should eq('full_house')
    end
  end

  describe '#four_of_a_kind' do
    it 'should recognize four of a kind' do
      hand = Hands::Hand.new
      hand << Hands::Card[7, :hearts]
      hand << Hands::Card[7, :spades]
      hand << Hands::Card[7, :diamonds]
      hand << Hands::Card[7, :clubs]
      hand << Hands::Card[9, :clubs]
      hand.best_hand[:type].should eq('four_of_a_kind')
    end
  end

  describe '#straight_flush' do
    it 'should recognize a straight flush' do
      hand = Hands::Hand.new
      hand << Hands::Card[2, :hearts]
      hand << Hands::Card[3, :hearts]
      hand << Hands::Card[4, :hearts]
      hand << Hands::Card[5, :hearts]
      hand << Hands::Card[6, :hearts]
      hand.best_hand[:type].should eq('straight_flush')
    end
  end

  describe '#best_hand' do
    it 'should recognize the best hand'  do
      hand = Hands::Hand.new
      hand << Hands::Card[7, :hearts]
      hand << Hands::Card[7, :spades]
      hand << Hands::Card[4, :diamonds]
      hand << Hands::Card[9, :hearts]
      hand << Hands::Card[9, :clubs]
      hand.best_hand[:type].should eq('two_pair')
    end
  end
end
