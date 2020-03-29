class GildedRose
  KLASS = {
    'Aged Brie' => 'AgedBrie',
    'Sulfuras, Hand of Ragnaros' => 'Sulfuras',
    'Backstage passes to a TAFKAL80ETC concert' => 'Backstage',
  }.freeze

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each { |item| ItemUpdater.const_get(KLASS[item.name] || 'Common').update(item) }
  end
end

module ItemUpdater
  class Base
    def self.update(item)
      item.sell_in -= 1
    end
  end

  class Common < Base
    def self.update(item)
      super

      item.quality -=1 if item.quality > 0
    end
  end

  class AgedBrie < Base
    def self.update(item)
      super

      return if item.quality == 50
      return item.quality += 2 if item.sell_in < 0

      item.quality +=1
    end
  end

  class Sulfuras < Base
    def self.update(item); end
  end

  class Backstage < Base
    def self.update(item)
      super

      return item.quality = 0 if item.sell_in < 0
      return item.quality +=3 if item.sell_in <= 5
      return item.quality +=2 if item.sell_in <= 10
      item.quality += 1
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

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end