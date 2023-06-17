class User < ApplicationRecord
    has_secure_password
    has_many :orders

   validates :email, presence: true, uniqueness: true
   validates :phone_number, presence: true, uniqueness: true, length: {is: 13}
   validates :password, confirmation: true, length: {minimum: 8, maximum: 70}
   validates :name, presence: true, length: {minimum: 2, maximum: 40}
end
