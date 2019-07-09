require File.join(File.dirname(__FILE__), 'gilded_rose')
require File.join(File.dirname(__FILE__), 'texttest_fixture')

describe GildedRose do
  describe '#update_quality' do
    before(:all) do
      $gilded_rose.update_quality
    end

    it 'does not change the name' do
      expect($gilded_rose.items[0].name).to eq('+5 Dexterity Vest')
    end

    it 'quality should be lowered' do
      expect($gilded_rose.items[0].quality).to eq(19)
    end

    it 'Sell date should be lowered' do
      expect($gilded_rose.items[0].sell_in).to eq(9)
    end

    it 'The Quality of an item should be never more than 50' do
      expect($gilded_rose.items[6].quality).to be <= 50
      expect($gilded_rose.items[7].quality).to be <= 50
    end

    it '\'Aged Brie\' should increases in Quality the older it gets' do
      expect($gilded_rose.items[1].quality).to be > 0
    end

  end
end
