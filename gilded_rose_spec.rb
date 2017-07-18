require_relative 'gilded_rose'

describe "update_quality" do
  context "regular item" do
    let(:item) { Item.new 'Mirror', 3, 20 }
    let(:expired_item) { Item.new 'Mirror', 0, 20 }

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

    it "after the sell date has passed, quality degrages twice as fast" do
      expect(expired_item.sell_in).to eq 0
      expect { tick expired_item }.to change { expired_item.quality }.by(-2)
    end
  end
end
