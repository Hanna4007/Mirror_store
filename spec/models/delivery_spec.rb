# frozen_string_literal: true

require 'rails_helper'
# rubocop:disable Naming/VariableNumber
RSpec.describe Delivery, type: :model do
  let(:delivery) { FactoryBot.build(:delivery) }

  let(:delivery_1) { FactoryBot.build(:delivery, delivery_type: 'Delivery to a store') }
  let(:delivery_2) { FactoryBot.build(:delivery, post: 'Delivery') }
  let(:delivery_3) { FactoryBot.build(:delivery, receiver_name: nil) }
  let(:delivery_4) { FactoryBot.build(:delivery, receiver_name: 'A' * 41) }
  let(:delivery_5) { FactoryBot.build(:delivery, receiver_surname: nil) }
  let(:delivery_6) { FactoryBot.build(:delivery, receiver_surname: 'A' * 41) }
  let(:delivery_7) { FactoryBot.build(:delivery, receiver_phone_number: nil) }
  let(:delivery_8) { FactoryBot.build(:delivery, receiver_phone_number: '+38066') }
  let(:delivery_9) { FactoryBot.build(:delivery, receiver_phone_number: '+38066111222h') }
  let(:delivery_10) { FactoryBot.build(:delivery, city: nil) }
  let(:delivery_11) { FactoryBot.build(:delivery, city: 'A' * 21) }
  let(:delivery_12) { FactoryBot.build(:delivery, region: nil) }
  let(:delivery_13) { FactoryBot.build(:delivery, region: 'A' * 21) }

  let(:delivery_14) do
    FactoryBot.build(:delivery, delivery_type: 'Delivery to the post office',
                                post_office_number: '5')
  end
  let(:delivery_15) do
    FactoryBot.build(:delivery, delivery_type: 'Delivery to the post office',
                                post_office_number: nil)
  end
  let(:delivery_16) do
    FactoryBot.build(:delivery, delivery_type: 'Delivery to the post office',
                                post_office_number: '0')
  end

  let(:delivery_17) do
    FactoryBot.build(:delivery, delivery_type: 'Delivery by courier',
                                receiver_address: 'Kevin Brook, 282')
  end
  let(:delivery_18) do
    FactoryBot.build(:delivery, delivery_type: 'Delivery by courier',
                                receiver_address: nil)
  end

  it 'is valid with valid attributes' do
    expect(delivery).to be_valid
  end

  it 'is invalid with invalid delivery_type' do
    expect(delivery_1).to be_invalid
  end

  it 'is invalid with invalid post' do
    expect(delivery_2).to be_invalid
  end

  it 'is invalid with invalid receiver_name' do
    expect(delivery_3).to be_invalid
    expect(delivery_4).to be_invalid
  end

  it 'is invalid with invalid receiver_surname' do
    expect(delivery_5).to be_invalid
    expect(delivery_6).to be_invalid
  end

  it 'is invalid with invalid receiver_phone_number' do
    expect(delivery_7).to be_invalid
    expect(delivery_8).to be_invalid
    expect(delivery_9).to be_invalid
  end

  it 'is invalid with invalid city' do
    expect(delivery_10).to be_invalid
    expect(delivery_11).to be_invalid
  end

  it 'is invalid with invalid region' do
    expect(delivery_12).to be_invalid
    expect(delivery_13).to be_invalid
  end

  it 'delivery checking when delivery_to_the_post_office' do
    expect(delivery_14).to be_valid
    expect(delivery_15).to be_invalid
    expect(delivery_16).to be_invalid
  end

  it 'delivery checking when delivery_by_courier' do
    expect(delivery_17).to be_valid
    expect(delivery_18).to be_invalid
  end
  # rubocop:enable Naming/VariableNumber
end
