require_relative 'gilded_rose'

describe "update_quality" do
  context "regular item" do
    let(:item) { Item.new 'Mirror', 3, 20 }

    it "sell_in and quality decrease by 1" do
      tick item
      expect(item.sell_in).to eq 2
      expect(item.quality).to eq 19
    end
  end
end
