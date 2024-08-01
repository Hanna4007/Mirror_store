# frozen_string_literal: true

require 'rails_helper'
# rubocop:disable Naming/VariableNumber
RSpec.describe Mirror, type: :model do
  let(:mirror) { FactoryBot.build(:mirror) }
  let(:mirror_1) { FactoryBot.create(:mirror) }

  let(:order_item_1) { FactoryBot.create(:order_item, mirror: mirror_1) }
  let(:order_item_2) { FactoryBot.create(:order_item, mirror: mirror_1) }


  let(:mirror_2) { FactoryBot.build(:mirror, height: nil) }
  let(:mirror_3) { FactoryBot.build(:mirror, height: 60) }
  let(:mirror_4) { FactoryBot.build(:mirror, width: nil) }
  let(:mirror_5) { FactoryBot.build(:mirror, width: 60) }
  let(:mirror_6) { FactoryBot.build(:mirror, glass_thickness: nil) }
  let(:mirror_7) { FactoryBot.build(:mirror, glass_thickness: 5) }
  let(:mirror_8) { FactoryBot.build(:mirror, light: nil) }
  let(:mirror_9) { FactoryBot.build(:mirror, light: 'red') }
  let(:mirror_10) { FactoryBot.build(:mirror, installation: nil) }
  let(:mirror_11) { FactoryBot.build(:mirror, installation: 'floor') }
  let(:mirror_12) { FactoryBot.build(:mirror, lamp: nil) }
  let(:mirror_13) { FactoryBot.build(:mirror, lamp: 'inside') }
  let(:mirror_14) { FactoryBot.build(:mirror, price_square: nil) }

  let(:mirror_15) { FactoryBot.create(:mirror, installation: 'wall') }
  let(:mirror_16) { FactoryBot.create(:mirror, installation: 'table') }
  let(:mirror_17) { FactoryBot.create(:mirror, lamp: 'built-in') }
  let(:mirror_18) { FactoryBot.create(:mirror, lamp: 'outside') }
  let(:mirror_19) { FactoryBot.create(:mirror, price_square: 10_000) }
  let(:mirror_20) { FactoryBot.create(:mirror, price_square: 30_000) }
  let(:mirror_21) { FactoryBot.create(:mirror, price_square: 20_000) }

  let(:mirror_22) { FactoryBot.create(:mirror, height: 50, width: 50, glass_thickness: 4, heater: false, price_square: 10_000) }
  let(:mirror_23) { FactoryBot.create(:mirror, height: 80, width: 50, glass_thickness: 4, heater: false, price_square: 10_000) }
  let(:mirror_24) { FactoryBot.create(:mirror, height: 100, width: 80, glass_thickness:6, heater: true, price_square: 10_000) }

  it 'has many order_items' do
    expect(mirror_1.order_items).to include(order_item_1, order_item_2)
  end

  it 'has many attached mirror images' do
    expect(mirror_1).to respond_to(:mirror_images)
    expect(mirror_1.mirror_images).to be_an_instance_of(ActiveStorage::Attached::Many)
  end

  it 'has rich text description' do
    expect(mirror_1).to respond_to(:description)
    expect(mirror_1.description).to be_an_instance_of(ActionText::RichText)
  end

  context 'for validations' do
    it 'is valid with valid attributes' do
      expect(mirror).to be_valid
    end

    it 'is invalid with invalid height' do
      expect(mirror_2).to be_invalid
      expect(mirror_3).to be_invalid
    end

    it 'is invalid with invalid width' do
      expect(mirror_4).to be_invalid
      expect(mirror_5).to be_invalid
    end

    it 'is invalid with invalid glass_thickness' do
      expect(mirror_6).to be_invalid
      expect(mirror_7).to be_invalid
    end

    it 'is invalid with invalid light' do
      expect(mirror_8).to be_invalid
      expect(mirror_9).to be_invalid
    end

    it 'is invalid with invalid installation' do
      expect(mirror_10).to be_invalid
      expect(mirror_11).to be_invalid
    end

    it 'is invalid with invalid lamp' do
      expect(mirror_12).to be_invalid
      expect(mirror_13).to be_invalid
    end

    it 'is invalid with invalid price_square' do
      expect(mirror_14).to be_invalid
    end
  end

  context 'for method filter_installation' do
    it 'selects correct mirrors when installation is wall' do
      expect(Mirror.filter_installation('wall')).to include(mirror_15)
      expect(Mirror.filter_installation('wall')).not_to include(mirror_16)
    end

    it 'selects correct mirrors when installation is table' do
      expect(Mirror.filter_installation('table')).to include(mirror_16)
      expect(Mirror.filter_installation('table')).not_to include(mirror_15)
    end

    it 'returns all mirrors' do
      expect(Mirror.filter_installation(nil)).to include(mirror_15, mirror_16)
      expect(Mirror.filter_installation('123')).to include(mirror_15, mirror_16)
    end
  end

  context 'for method filter_lamp' do
    it 'selects correct mirrors when lamp is built-in' do
      expect(Mirror.filter_lamp('built-in')).to include(mirror_17)
      expect(Mirror.filter_lamp('built-in')).not_to include(mirror_18)
    end

    it 'selects correct mirrors when lamp is outside' do
      expect(Mirror.filter_lamp('outside')).to include(mirror_18)
      expect(Mirror.filter_lamp('outside')).not_to include(mirror_17)
    end

    it 'returns all mirrors' do
      expect(Mirror.filter_lamp(nil)).to include(mirror_17, mirror_18)
      expect(Mirror.filter_lamp('123')).to include(mirror_17, mirror_18)
    end
  end

  context 'for method with_field_order' do
    it 'sorts mirrors in descending order' do
      expect(Mirror.with_field_order('price_square-desc-in')).to eq([mirror_20, mirror_21, mirror_19])
    end

    it 'sorts mirrors in ascending order' do
      expect(Mirror.with_field_order('price_square-asc')).to eq([mirror_19, mirror_21, mirror_20])
    end

    it 'sorts mirrors in recomended order' do
      expect(Mirror.with_field_order('')).to eq([mirror_19, mirror_20, mirror_21])
      expect(Mirror.with_field_order('123')).to eq([mirror_19, mirror_20, mirror_21])
    end
  end

  context 'for method price_calculation' do
    it 'calculates price correctly' do
      expect(mirror_22.price_calculation).to eq(2_500)
      expect(mirror_23.price_calculation).to eq(4_600)
      expect(mirror_24.price_calculation).to eq(12_145)
    end
  end
  # rubocop:enable Naming/VariableNumber
end
