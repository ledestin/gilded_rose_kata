require_relative 'gilded_rose'

describe "update_quality" do
  let(:regular_item) { Item.new 'Mirror', 3, 20 }

  context "regular item" do
    it "sell_in and quality decrease by 1" do
      tick regular_item
      expect(regular_item.sell_in).to eq 2
      expect(regular_item.quality).to eq 19
    end
  end
end
