class User < ApplicationRecord
    has_secure_password
    has_many :orders

   validates :email, presence: true, uniqueness: true
   validates :phone_number, presence: true, uniqueness: true, length: {is: 13}
   validates :password, confirmation: true, length: {minimum: 8, maximum: 70}, if: :password_validation_required?
   validates :name, presence: true, length: {minimum: 2, maximum: 40}
   
   scope :filter_phone_number, ->(value) { where(phone_number: value) unless value.blank? }
   scope :filter_status, ->(value) { where(admin: value) unless value.blank? }

  private

  def password_validation_required?
    new_record? || password_digest_changed?
  end
end
