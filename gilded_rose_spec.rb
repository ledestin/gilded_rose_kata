require_relative 'gilded_rose'

describe "update_quality" do
  context "regular item" do
    let(:item) { Item.new 'Mirror', 3, 20 }
    let(:expired_item) { Item.new 'Mirror', 0, 20 }
    let(:zero_quality_item) { Item.new 'Mirror', 1, 0 }

    it "sell_in and quality decrease by 1" do
      tick item
      expect(item.sell_in).to eq 2
      expect(item.quality).to eq 19
    end

    it "sell_in decreases below zero" do
      expect(expired_item.sell_in).to eq 0
      tick expired_item
      expect(expired_item.sell_in).to eq -1
    end

    it "quality never goes into negative" do
      expect(zero_quality_item.quality).to eq 0
      expect { tick zero_quality_item }.not_to \
        change { zero_quality_item.quality }
    end

    it "after the sell date has passed, quality degrages twice as fast" do
      expect(expired_item.sell_in).to eq 0
      expect { tick expired_item }.to change { expired_item.quality }.by(-2)
    end
  end

  context "Aged Brie" do
    let(:aged_brie) { Item.new "Aged Brie", 3, 2 }
    let(:expired_aged_brie) { Item.new "Aged Brie", 0, 2 }
    let(:aged_brie_quality_50) { Item.new "Aged Brie", 0, 50 }

    it "increases in quality as it gets older" do
      expect { tick aged_brie }.to change { aged_brie.quality }.by(1)
    end

    it "expired brie increases in quality twice as fast" do
      expect { tick expired_aged_brie }.to \
        change { expired_aged_brie.quality }.by(2)
    end

    it "quality is never more than 50" do
      expect(aged_brie_quality_50.quality).to eq 50
      expect { tick aged_brie_quality_50 }.not_to \
        change { aged_brie_quality_50.quality }
    end

    it "sell_in decreases by 1" do
      expect { tick aged_brie }.to change { aged_brie.sell_in }.by(-1)
    end
  end

  context "Sulfuras" do
    let(:sulfuras) { Item.new "Sulfuras, Hand of Ragnaros", 1, 10 }

    it "never decreases in quality" do
      expect { tick sulfuras }.not_to change { sulfuras.quality }
    end

    it "never has to be sold" do
      expect { tick sulfuras }.not_to change { sulfuras.sell_in }
    end
  end
end
