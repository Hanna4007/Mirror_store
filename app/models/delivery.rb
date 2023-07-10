class Delivery < ApplicationRecord
  belongs_to :order

  validates :delivery_type, presence: true
  VALID_DELIVERY_TYPE = [ 'Delivery to the post office', 'Delivery by courier' ]
  validates :delivery_type, inclusion: { in: VALID_DELIVERY_TYPE }

  validates :post, presence: true
  VALID_DELIVERY_TYPE = [ 'Nova post', 'Ukrpost' ]
  validates :post, inclusion: { in: VALID_DELIVERY_TYPE }

  validates :receiver_name, presence: true, length: {minimum: 2, maximum: 40}

  validates :receiver_surname, presence: true, length: {minimum: 2, maximum: 40}

  validates :receiver_phone_number, presence: true, length: {is: 13}

  validates :city, presence: true

  validates :region, presence: true

  validates :post_office_number, presence: true, if: -> { delivery_type == 'Delivery to the post office' }

  validates :receiver_address, presence: true, if: -> { delivery_type == 'Delivery by courier' }
  
end
