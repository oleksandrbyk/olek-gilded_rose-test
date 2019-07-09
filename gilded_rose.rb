class GildedRose
  attr_accessor :items

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      # 'Sulfuras', being a legendary item, never has to be sold or decreases in Quality
      next if item.is_sulfuras

      # 'Aged Brie' actually increases in Quality the older it gets
      # 'Backstage passes', like aged brie, increases in Quality as its SellIn value approaches;
      # Quality increases by 2 when there are 10 days or less and
      # by 3 when there are 5 days or less but Quality drops to 0 after the concert
      if item.is_backstage_passes
        # Quality increases
        item.quality += 1 if item.quality < 50
        item.quality += 1 if item.quality < 50 && item.sell_in <= 10 # by 2 when there are 10 days or less
        item.quality += 1 if item.quality < 50 && item.sell_in <= 5 # by 3 when there are 5 days or less
        next
      end

      # At the end of each day our system lowers both values for every item
      item.sell_in -= 1
      next if item.quality <= 0
      item.quality -= 1

      # Once the sell by date has passed, Quality degrades twice as fast
      # 'Conjured' items degrade in Quality twice as fast as normal items
      item.quality -= 1 if item.is_conjured || item.passed_sell_date
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def is_conjured
    name.start_with? 'Conjured'
  end

  def is_sulfuras
    name.start_with? 'Sulfuras'
  end

  def is_backstage_passes
    name.start_with?('Backstage passes', 'Aged Brie')
  end

  def is_aged_brie
    name.start_with? 'Aged Brie'
  end

  def passed_sell_date
    sell_in < 0
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
