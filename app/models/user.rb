# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :orders

  before_save :capitalize_name

  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true, format: { with: /\A\+\d+\z/ }, length: { is: 13 }
  validates :password, confirmation: true, length: { minimum: 8, maximum: 70 }, if: :password_validation_required?
  validates :password_confirmation, presence: true, if: :password_digest_changed?
  validates :name, presence: true, length: { minimum: 2, maximum: 40 }

  scope :filter_phone_number, ->(value) { where(phone_number: value) unless value.blank? }

  scope :filter_status, ->(value) {
  if value == '1'
    where(admin: true)
  elsif value == '0'
    where(admin: false)
  else
    all
  end
}


  private

  def password_validation_required?
    new_record? || password_digest_changed?
  end

  def capitalize_name
    self.name = name.capitalize
  end
end
