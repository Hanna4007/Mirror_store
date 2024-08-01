# frozen_string_literal: true

require 'rails_helper'
# rubocop:disable Naming/VariableNumber
RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }
  let(:user_1) { FactoryBot.build(:user, email: nil) }
  let(:user_2) { FactoryBot.build(:user, email: 'olena@gmail.com') }
  let(:user_3) { FactoryBot.build(:user, email: 'olena@gmail.com') }

  let(:user_4) { FactoryBot.build(:user, phone_number: nil) }
  let(:user_5) { FactoryBot.build(:user, phone_number: '+380661112222') }
  let(:user_6) { FactoryBot.build(:user, phone_number: '+380661112222') }
  let(:user_7) { FactoryBot.build(:user, phone_number: '+38066') }
  let(:user_8) { FactoryBot.build(:user, phone_number: '+38066111222h') }
  let(:user_9) { FactoryBot.build(:user, phone_number: '3806611122222') }

  let(:user_10) { FactoryBot.build(:user, password: nil) }
  let(:user_11) { FactoryBot.build(:user, password: '12345678', password_confirmation: nil) }
  let(:user_12) { FactoryBot.build(:user, password: '12345678', password_confirmation: '87654321') }

  let(:user_13) { FactoryBot.create(:user, phone_number: '+380661112222') }
  let(:user_14) { FactoryBot.create(:user, phone_number: '+380987654321') }

  let(:user_15) { FactoryBot.create(:user, admin: true) }
  let(:user_16) { FactoryBot.create(:user) }

  let(:user_17) { FactoryBot.build(:user, name: nil) }
  let(:user_18) { FactoryBot.build(:user, name: 'a') }
  let(:user_19) { FactoryBot.build(:user, name: 'a'*41) }
  let(:user_20) { FactoryBot.create(:user, name: 'ann') }

  let(:order_1) { FactoryBot.create(:order, user:) }
  let(:order_2) { FactoryBot.create(:order, user:) }

  it 'has many orders' do
    expect(user.orders).to include(order_1, order_2)
  end

  context 'for validations if a new record has been created' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a correct email' do
      expect(user_1).to be_invalid
      user_2.save
      expect(user_3).to be_invalid
    end

    it 'is not valid without a correct phone number' do
      expect(user_4).to be_invalid
      user_5.save
      expect(user_6).to be_invalid
      expect(user_7).to be_invalid
      expect(user_8).to be_invalid
      expect(user_9).to be_invalid
    end

    it 'is not valid without password' do
      expect(user_10).to be_invalid
    end

    it 'is not valid without correct password confirmation' do
      expect(user_11).to be_invalid
      expect(user_12).to be_invalid
    end

    
    it 'is not valid without correct name' do
      expect(user_17).to be_invalid
      expect(user_18).to be_invalid
      expect(user_19).to be_invalid
    end
  end

  context 'for validations if attributes have been changed' do
    it 'is invalid whithout confirmation if password has been changed' do
      user.save
      user.password = '87654321'
      expect(user).to be_invalid
    end

    it 'is valid whith confirmation if password has been changed' do
      user.save
      user.password = '87654321'
      user.password_confirmation = '87654321'
      expect(user).to be_valid
    end

    it 'is valid if name, phone_number, email have been changed' do
      user.save
      user.name = 'New Name'
      user.phone_number = '+380987654321'
      user.email = 'new_email@gmail'
      expect(user).to be_valid
    end
  end

  context 'for method filter_phone_number' do
    it 'returns user with specified phone number' do
      expect(User.filter_phone_number('+380661112222')).to include(user_13)
    end

    it 'does not return users with different phone number' do
      expect(User.filter_phone_number('+380661112222')).not_to include(user_14)
    end

    it 'returns all users without phone number' do
      expect(User.filter_phone_number(nil)).to include(user_13, user_14)
    end
  end

  context 'for method filter_status' do
    it 'selects admin when admin status filter is true' do
      expect(User.filter_status('1')).to include(user_15)
      expect(User.filter_status('1')).not_to include(user_16)
    end

    it 'selects users when admin status filter is false' do
      expect(User.filter_status('0')).to include(user_16)
      expect(User.filter_status('0')).not_to include(user_15)
    end

    it 'returns all users' do
      expect(User.filter_status(nil)).to include(user_15, user_16)
      expect(User.filter_status('123')).to include(user_15, user_16)
    end
  end

  it 'is a capitalized name' do
    expect(user_20.name).to eq('Ann')      
  end
end
# rubocop:enable Naming/VariableNumber
