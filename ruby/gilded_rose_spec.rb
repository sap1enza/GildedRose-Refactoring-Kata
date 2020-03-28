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

            expect(aged_brie.to_s).to eq('Aged Brie, 9, 1')
          end
        end

        context 'when passed 5 days' do
          it 'sell_in and quality must be 5' do
            update_quality_of([aged_brie], days: 5)

            expect(aged_brie.to_s).to eq('Aged Brie, 5, 5')
          end
        end

        context 'when passed 9 days' do
          it 'sell_in must be 1 and quality 9' do
            update_quality_of([aged_brie], days: 9)

            expect(aged_brie.to_s).to eq('Aged Brie, 1, 9')
          end
        end

        context 'when sell by date has passed 5 days' do
          it 'sell_in must be -5 and quality 20' do
            update_quality_of([aged_brie], days: sell_in + 5)

            expected_quality = sell_in + (5 * 2)

            expect(aged_brie.to_s).to eq("Aged Brie, -5, #{expected_quality}")
          end
        end

        context 'when sell by date has passed 60 days' do
          it 'sell_in must be -60 and quality the maximum of 50' do
            update_quality_of([aged_brie], days: sell_in + 60)

            expect(aged_brie.to_s).to eq('Aged Brie, -60, 50')
          end
        end
      end
    end

    context 'when name is Conjured Mana Cake' do
      context 'with sell_in 10' do
        let(:sell_in) { 3 }
        let(:conjured_cake) { Item.new('Conjured Mana Cake', sell_in, 6) }

        context 'when passed 1 day' do
          it 'sell_in must be 2 and quality 5' do
            update_quality_of([conjured_cake], days: 1)

            expect(conjured_cake.to_s).to eq('Conjured Mana Cake, 2, 5')
          end
        end

        context 'when passed 5 days' do
          it 'sell_in must be -2 and quality 1' do
            update_quality_of([conjured_cake], days: 5)

            expect(conjured_cake.to_s).to eq('Conjured Mana Cake, -2, 1')
          end
        end

        context 'when passed 9 days' do
          it 'sell_in must be -6 and quality 0' do
            update_quality_of([conjured_cake], days: 9)

            expect(conjured_cake.to_s).to eq('Conjured Mana Cake, -6, 0')
          end
        end

        context 'when sell by date has passed 5 days' do
          it 'sell_in must be -5 and quality 0' do
            update_quality_of([conjured_cake], days: sell_in + 5)

            expect(conjured_cake.to_s).to eq("Conjured Mana Cake, -5, 0")
          end
        end

        context 'when sell by date has passed 60 days' do
          it 'sell_in must be -60 and quality the minimum of 0' do
            update_quality_of([conjured_cake], days: sell_in + 60)

            expect(conjured_cake.to_s).to eq('Conjured Mana Cake, -60, 0')
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

            expect(sulfuras.to_s).to eq('Sulfuras, Hand of Ragnaros, 0, 80')
          end
        end

        context 'when passed 5 days' do
          it 'sell_in must be 0 and quality 80' do
            update_quality_of([sulfuras], days: 5)

            expect(sulfuras.to_s).to eq('Sulfuras, Hand of Ragnaros, 0, 80')
          end
        end

        context 'when passed 9 days' do
          it 'sell_in must be 0 and quality 80' do
            update_quality_of([sulfuras], days: 9)

            expect(sulfuras.to_s).to eq('Sulfuras, Hand of Ragnaros, 0, 80')
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

            expect(backstage.to_s).to eq('Backstage passes to a TAFKAL80ETC concert, 14, 21')
          end
        end

        context 'when passed 5 days' do
          it 'sell_in must be 10 and quality 25' do
            update_quality_of([backstage], days: 5)

            expect(backstage.to_s).to eq('Backstage passes to a TAFKAL80ETC concert, 10, 25')
          end
        end

        context 'when passed 9 days' do
          it 'sell_in must be 6 and quality 33' do
            update_quality_of([backstage], days: 9)

            expect(backstage.to_s).to eq('Backstage passes to a TAFKAL80ETC concert, 6, 33')
          end
        end

        context 'when passed 13 days' do
          it 'sell_in must be 2 and quality 44' do
            update_quality_of([backstage], days: 13)

            expect(backstage.to_s).to eq('Backstage passes to a TAFKAL80ETC concert, 2, 44')
          end
        end

        context 'when sell by date has passed 7 days' do
          it 'sell_in must be -7 and quality 0' do
            update_quality_of([backstage], days: sell_in + 7)

            expect(backstage.to_s).to eq('Backstage passes to a TAFKAL80ETC concert, -7, 0')
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
