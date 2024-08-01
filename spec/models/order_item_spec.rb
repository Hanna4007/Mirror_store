require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:mirror_1) { FactoryBot.create(:mirror, height: 50, width: 50, glass_thickness: 4, heater: false, price_square: 10_000) }
  let(:mirror_2) { FactoryBot.create(:mirror, height: 80, width: 50, glass_thickness: 4, heater: false, price_square: 10_000) }
  let(:mirror_3) { FactoryBot.create(:mirror, height: 100, width: 80, glass_thickness:6, heater: true, price_square: 10_000) }
  
  let(:order_item_1) { FactoryBot.create(:order_item, mirror: mirror_1, quantity: 1) }
  let(:order_item_2) { FactoryBot.create(:order_item, mirror: mirror_2, quantity: 2) }
  let(:order_item_3) { FactoryBot.create(:order_item, mirror: mirror_3, quantity: 3) }

  
  it 'updates total_price_item' do
    [order_item_1, order_item_2, order_item_3].each do |order_item|
    order_item.send(:update_total_price_item)
    end
    expect(order_item_1.total_price_item).to eq(2_500)
    expect(order_item_2.total_price_item).to eq(9_200)
    expect(order_item_3.total_price_item).to eq(36_435)
  end
end
