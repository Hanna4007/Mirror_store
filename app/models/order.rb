# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_items
  has_one :delivery
  belongs_to :user
  before_save :set_total_price

  VALID_STATUS = ['in progress', 'confirmed', 'waiting for payment', 'paid', 'delivered', 'canceled'].freeze
  validates :status, inclusion: { in: VALID_STATUS }

  scope :filter_status, ->(value) { where(status: value) unless value.blank? }
  scope :with_field_order, lambda { |field = nil, focus = nil|
                             allowed_fields = ['updated_at']
                             field = nil if allowed_fields.exclude?(field)

                             direction = focus == 'desc' ? 'desc' : 'asc'

                             order(field => direction) if field
                           }

  scope :find_by_user_phone, ->(value) { joins(:user).where(users: { phone_number: value }) unless value.blank? }

  def total_price
    order_items.includes(:mirror).map { |order_item| order_item.valid? ? successful_order_item(order_item) : 0 }.sum
  end

  private

  def set_total_price
    self.total_price = total_price
  end

  def successful_order_item(order_item)
    order_item.unit_price * order_item.quantity
  end
end
