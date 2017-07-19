require_relative "gilded_rose"

describe "tick" do
  let(:item) { Item.new initial_name, initial_sell_in, initial_quality }
  let(:initial_sell_in) { 10 }
  let(:initial_quality) { 5 }

  before { tick item }

  context "regular item" do
    let(:initial_name) { "Mirror" }

    context "before sell date" do
      let(:initial_sell_in) { 5 }
      let(:initial_quality) { 5 }

      specify "sell_in decreases by 1" do
        expect(item.sell_in).to eq initial_sell_in-1
      end

      specify "quality decreases by 1" do
        expect(item.quality).to eq initial_quality-1
      end
    end

    context "on the sell date" do
      let(:initial_sell_in) { 0 }
      let(:initial_quality) { 5 }

      specify "sell_in decreases by 1" do
        expect(item.sell_in).to eq initial_sell_in-1
      end

      specify "quality decreases twice as fast" do
        expect(item.quality).to eq initial_quality-2
      end
    end

    context "after the sell date" do
      let(:initial_sell_in) { -5 }
      let(:initial_quality) { 5 }

      specify "sell_in decreases by 1" do
        expect(item.sell_in).to eq initial_sell_in-1
      end

      specify "quality decreases twice as fast" do
        expect(item.quality).to eq initial_quality-2
      end
    end

    context "quality is never negative" do
      let(:initial_sell_in) { -5 }
      let(:initial_quality) { 0 }

      it { expect(item.quality).to eq 0 }
    end
  end

  context "Aged Brie" do
    let(:initial_name) { "Aged Brie" }

    context "before sell date" do
      let(:initial_sell_in) { 5 }
      let(:initial_quality) { 5 }

      specify "sell_in decreases by 1" do
        expect(item.sell_in).to eq initial_sell_in-1
      end

      specify "quality increases by 1" do
        expect(item.quality).to eq initial_quality+1
      end
    end

    context "on the sell date" do
      let(:initial_sell_in) { 0 }
      let(:initial_quality) { 5 }

      specify "sell_in decreases by 1" do
        expect(item.sell_in).to eq initial_sell_in-1
      end

      specify "quality increases twice as fast" do
        expect(item.quality).to eq initial_quality+2
      end
    end

    context "after the sell date" do
      let(:initial_sell_in) { -5 }
      let(:initial_quality) { 5 }

      specify "sell_in decreases by 1" do
        expect(item.sell_in).to eq initial_sell_in-1
      end

      specify "quality decreases twice as fast" do
        expect(item.quality).to eq initial_quality+2
      end
    end

    context "quality is never more than 50" do
      let(:initial_sell_in) { -5 }
      let(:initial_quality) { 50 }

      it { expect(item.quality).to eq 50 }
    end
  end

  context "Sulfuras" do
    let(:initial_name) { "Sulfuras, Hand of Ragnaros" }

    context "before sell date" do
      let(:initial_sell_in) { 5 }
      let(:initial_quality) { 5 }

      specify "sell_in decreases by 1" do
        expect(item.sell_in).to eq initial_sell_in
      end

      specify "quality decreases by 1" do
        expect(item.quality).to eq initial_quality
      end
    end

    context "on the sell date" do
      let(:initial_sell_in) { 0 }
      let(:initial_quality) { 5 }

      specify "sell_in decreases by 1" do
        expect(item.sell_in).to eq initial_sell_in
      end

      specify "quality decreases twice as fast" do
        expect(item.quality).to eq initial_quality
      end
    end

    context "after the sell date" do
      let(:initial_sell_in) { -5 }
      let(:initial_quality) { 5 }

      specify "sell_in decreases by 1" do
        expect(item.sell_in).to eq initial_sell_in
      end

      specify "quality decreases twice as fast" do
        expect(item.quality).to eq initial_quality
      end
    end
  end

  context "Backstage pass" do
    let(:initial_name) { "Backstage passes to a TAFKAL80ETC concert" }

    context "long before sell date" do
      let(:initial_sell_in) { 11 }
      let(:initial_quality) { 5 }

      specify "sell_in decreases by 1" do
        expect(item.sell_in).to eq initial_sell_in-1
      end

      specify "quality increases by 1" do
        expect(item.quality).to eq initial_quality+1
      end
    end

    context "medium before sell date" do
      let(:initial_sell_in) { 10 }
      let(:initial_quality) { 5 }

      specify "sell_in decreases by 1" do
        expect(item.sell_in).to eq initial_sell_in-1
      end

      specify "quality increases by 2" do
        expect(item.quality).to eq initial_quality+2
      end

      context "lower bound" do
        let(:initial_sell_in) { 6 }

        specify "sell_in decreases by 1" do
          expect(item.sell_in).to eq initial_sell_in-1
        end

        specify "quality increases by 2" do
          expect(item.quality).to eq initial_quality+2
        end
      end
    end

    context "very close to sell date" do
      let(:initial_sell_in) { 5 }
      let(:initial_quality) { 5 }

      specify "sell_in decreases by 1" do
        expect(item.sell_in).to eq initial_sell_in-1
      end

      specify "quality increases by 3" do
        expect(item.quality).to eq initial_quality+3
      end

      context "lower bound" do
        let(:initial_sell_in) { 1 }

        specify "sell_in decreases by 1" do
          expect(item.sell_in).to eq initial_sell_in-1
        end

        specify "quality increases by 3" do
          expect(item.quality).to eq initial_quality+3
        end
      end
    end

    context "on the sell date" do
      let(:initial_sell_in) { 0 }
      let(:initial_quality) { 5 }

      specify "sell_in decreases by 1" do
        expect(item.sell_in).to eq initial_sell_in-1
      end

      specify "quality drops to zero after concert" do
        expect(item.quality).to eq 0
      end
    end

    context "after the sell date" do
      let(:initial_sell_in) { -1 }
      let(:initial_quality) { 0 }

      specify "sell_in decreases by 1" do
        expect(item.sell_in).to eq initial_sell_in-1
      end

      specify "quality drops to zero after concert" do
        expect(item.quality).to eq 0
      end
    end
  end

  context "Conjured" do
    let(:initial_name) { "Conjured Mana Cake" }

    context "before sell date" do
      let(:initial_sell_in) { 5 }
      let(:initial_quality) { 5 }

      specify "sell_in decreases by 1" do
        expect(item.sell_in).to eq initial_sell_in-1
      end

      specify "quality decreases by 2" do
        expect(item.quality).to eq initial_quality-2
      end

      context "quality is never negative" do
        let(:initial_quality) { 1 }

        it { expect(item.quality).to eq 0 }
      end
    end

    context "before sell date (lower bound)" do
      let(:initial_sell_in) { 1 }
      let(:initial_quality) { 5 }

      specify "sell_in decreases by 1" do
        expect(item.sell_in).to eq initial_sell_in-1
      end

      specify "quality decreases by 2" do
        expect(item.quality).to eq initial_quality-2
      end

      context "quality is never negative" do
        let(:initial_quality) { 1 }

        it { expect(item.quality).to eq 0 }
      end
    end

    context "on the sell date" do
      let(:initial_sell_in) { 0 }
      let(:initial_quality) { 5 }

      specify "sell_in decreases by 1" do
        expect(item.sell_in).to eq initial_sell_in-1
      end

      specify "quality decreases by 4" do
        expect(item.quality).to eq initial_quality-4
      end

      context "quality is never negative" do
        let(:initial_quality) { 1 }

        it { expect(item.quality).to eq 0 }
      end
    end

    context "after the sell date" do
      let(:initial_sell_in) { -2 }
      let(:initial_quality) { 5 }

      specify "sell_in decreases by 1" do
        expect(item.sell_in).to eq initial_sell_in-1
      end

      specify "quality decreases by 4" do
        expect(item.quality).to eq initial_quality-4
      end

      context "quality is never negative" do
        let(:initial_quality) { 1 }

        it { expect(item.quality).to eq 0 }
      end
    end
  end
end
