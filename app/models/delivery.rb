# frozen_string_literal: true

class Delivery < ApplicationRecord
  belongs_to :order

  validates :delivery_type, presence: true
  VALID_DELIVERY_TYPE = ['Delivery to the post office', 'Delivery by courier'].freeze
  validates :delivery_type, inclusion: { in: VALID_DELIVERY_TYPE }

  validates :post, presence: true
  VALID_DELIVERY_TYPE = ['Nova post', 'Ukrpost'].freeze
  validates :post, inclusion: { in: VALID_DELIVERY_TYPE }

  validates :receiver_name, presence: true, length: { minimum: 2, maximum: 40 }

  validates :receiver_surname, presence: true, length: { minimum: 2, maximum: 40 }

  validates :receiver_phone_number, presence: true, length: { is: 13 }

  validates :city, presence: true, length: { minimum: 3, maximum: 20 }

  validates :region, presence: true, length: { minimum: 3, maximum: 20 }

  validates :post_office_number,
            presence: true,
            if: -> { delivery_type == 'Delivery to the post office' },
            numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  validates :receiver_address, presence: true, if: -> { delivery_type == 'Delivery by courier' }
end
