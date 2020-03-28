require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    context 'when name is Aged Brie' do
      context 'with sell_in 10' do
        let(:sell_in) { 10 }
        let(:aged_brie) { Item.new('Aged Brie', sell_in, 0) }

        context 'when passed 1 day' do
          it 'sell_in must be 9 and quality 1' do
            update_quality_of([aged_brie], days: 1)

            expect(aged_brie.sell_in).to eq(9)
            expect(aged_brie.quality).to eq(1)
          end
        end

        context 'when passed 5 days' do
          it 'sell_in and quality must be 5' do
            update_quality_of([aged_brie], days: 5)

            expect(aged_brie.sell_in).to eq(5)
            expect(aged_brie.quality).to eq(5)
          end
        end

        context 'when passed 9 days' do
          it 'sell_in must be 1 and quality 9' do
            update_quality_of([aged_brie], days: 9)

            expect(aged_brie.sell_in).to eq(1)
            expect(aged_brie.quality).to eq(9)
          end
        end

        context 'when sell by date has passed 5 days' do
          it 'sell_in must be -5 and quality 20' do
            update_quality_of([aged_brie], days: sell_in + 5)

            expected_quality = sell_in + (5 * 2)

            expect(aged_brie.sell_in).to eq(-5)
            expect(aged_brie.quality).to eq(expected_quality)
          end
        end

        context 'when sell by date has passed 60 days' do
          it 'sell_in must be -5 and quality the maximum of 50' do
            update_quality_of([aged_brie], days: sell_in + 60)

            expect(aged_brie.sell_in).to eq(-60)
            expect(aged_brie.quality).to eq(50)
          end
        end
      end
    end

    context 'when name is Sulfuras, Hand of Ragnaros' do
      context 'with sell_in 0' do
        let(:sulfuras) { Item.new(name="Sulfuras, Hand of Ragnaros", 0, 80) }

        context 'when passed 1 day' do
          it 'sell_in must be 0 and quality 80' do
            update_quality_of([sulfuras], days: 1)

            expect(sulfuras.sell_in).to eq(0)
            expect(sulfuras.quality).to eq(80)
          end
        end

        context 'when passed 5 days' do
          it 'sell_in must be 0 and quality 80' do
            update_quality_of([sulfuras], days: 5)

            expect(sulfuras.sell_in).to eq(0)
            expect(sulfuras.quality).to eq(80)
          end
        end

        context 'when passed 9 days' do
          it 'sell_in must be 0 and quality 80' do
            update_quality_of([sulfuras], days: 9)

            expect(sulfuras.sell_in).to eq(0)
            expect(sulfuras.quality).to eq(80)
          end
        end
      end
    end

    context 'when name is Backstage passes to a TAFKAL80ETC concert' do
      context 'with sell_in 15' do
        let(:sell_in) { 15 }
        let(:backstage) { Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in, 20) }

        context 'when passed 1 day' do
          it 'sell_in must be 14 and quality 21' do
            update_quality_of([backstage], days: 1)

            expect(backstage.sell_in).to eq(14)
            expect(backstage.quality).to eq(21)
          end
        end

        context 'when passed 5 days' do
          it 'sell_in must be 10 and quality 25' do
            update_quality_of([backstage], days: 5)

            expect(backstage.sell_in).to eq(10)
            expect(backstage.quality).to eq(25)
          end
        end

        context 'when passed 9 days' do
          it 'sell_in must be 6 and quality 33' do
            update_quality_of([backstage], days: 9)

            expect(backstage.sell_in).to eq(6)
            expect(backstage.quality).to eq(33)
          end
        end

        context 'when passed 13 days' do
          it 'sell_in must be 6 and quality 33' do
            update_quality_of([backstage], days: 13)

            expect(backstage.sell_in).to eq(2)
            expect(backstage.quality).to eq(44)
          end
        end

        context 'when sell by date has passed 7 days' do
          it 'sell_in must be -7 and quality 0' do
            update_quality_of([backstage], days: sell_in + 7)

            expect(backstage.sell_in).to eq(-7)
            expect(backstage.quality).to eq(0)
          end
        end
      end
    end
  end

  def update_quality_of(items , days:)
    gilded_rose = GildedRose.new items

    1.upto(days) { gilded_rose.update_quality }
  end
end
