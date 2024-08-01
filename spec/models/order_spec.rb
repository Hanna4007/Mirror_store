# frozen_string_literal: true

require 'rails_helper'
# rubocop:disable Naming/VariableNumber

RSpec.describe Order, type: :model do
  let(:order) { FactoryBot.create(:order) }

  let(:mirror_1) {FactoryBot.create(:mirror, height: 50, width: 50, glass_thickness: 4, heater: false, price_square: 10_000)}
  let(:mirror_2) {FactoryBot.create(:mirror, height: 80, width: 50, glass_thickness: 4, heater: false, price_square: 10_000)}
  
  let(:order_item_1) {FactoryBot.create(:order_item, order:, mirror: mirror_1, quantity: 2) }
  let(:order_item_2) {FactoryBot.create(:order_item, order:, mirror: mirror_2, quantity: 3) }

  let(:delivery_1) { FactoryBot.create(:delivery, order: order)}

  let(:order_1) { FactoryBot.build(:order, status: 'confirmed') }
  let(:order_2) { FactoryBot.build(:order, status: 'new') }

  let(:order_3) { FactoryBot.create(:order, status: 'in progress') }
  let(:order_4) { FactoryBot.create(:order, status: 'canceled') }
  let(:order_5) { FactoryBot.create(:order, status: 'confirmed') }

  let(:order_6) { FactoryBot.create(:order, updated_at: '2023-01-02') }
  let(:order_7) { FactoryBot.create(:order, updated_at: '2023-01-01') }
  let(:order_8) { FactoryBot.create(:order, updated_at: '2023-01-03') }

  let(:user_1) { FactoryBot.create(:user, phone_number: '+380661112222') }
  let(:user_2) { FactoryBot.create(:user, phone_number: '+380661113333') }
  let(:order_9) { FactoryBot.create(:order, user: user_1) }
  let(:order_10) { FactoryBot.create(:order, user: user_2) }

  it 'has many order_items' do
    expect(order.order_items).to include(order_item_1, order_item_2)
  end

  it 'has one delivery' do
    delivery_1
    expect(order.delivery).to eq(delivery_1)
  end

  it 'is valid with valid status' do
    expect(order_1).to be_valid
  end

  it 'is invalid with invalid status' do
    expect(order_2).to be_invalid
  end

  context 'for method filter_status' do
    it 'selects correct orders when status is in_progress' do
      expect(Order.filter_status('in progress')).to include(order_3)
      expect(Order.filter_status('in progress')).not_to include(order_4, order_5)
    end

    it 'selects correct orders when status is canceled' do
      expect(Order.filter_status('canceled')).to include(order_4)
      expect(Order.filter_status('canceled')).not_to include(order_3, order_5)
    end

    it 'returns all orders' do
      expect(Order.filter_status(nil)).to include(order_3, order_4, order_5)
      expect(Order.filter_status('123')).to include(order_3, order_4, order_5)
    end
  end

  context 'for method with_field_order' do
    it 'sorts orders in descending order' do
      expect(Order.with_field_order('updated_at-desc')).to eq([order_8, order_6, order_7])
    end

    it 'sorts orders in ascending order' do
      expect(Order.with_field_order('updated_at-asc')).to eq([order_7, order_6, order_8])
    end

    it 'sorts orders in recomended order' do
      expect(Order.with_field_order('')).to eq([order_6, order_7, order_8])
      expect(Order.with_field_order('123')).to eq([order_6, order_7, order_8])
    end
  end

  context 'for method find_by_user_phone' do
    it 'returns orders with specified user phone number' do
      expect(Order.find_by_user_phone('+380661112222')).to include(order_9)
    end

    it 'does not return orders with different user phone number' do
      expect(Order.find_by_user_phone('+380661112222')).not_to include(order_10)
    end

    it 'returns all orders without phone number' do
      expect(Order.find_by_user_phone(nil)).to include(order_9, order_10)
    end
  end

  it 'updates total_price' do
    order_item_1.send(:update_total_price)
    order_item_2.send(:update_total_price)
    order.send(:set_total_price)
    expect(order.total_price).to eq(18_800)
  end
end
# rubocop:enable Naming/VariableNumber
