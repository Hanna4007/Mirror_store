# frozen_string_literal: true

class OrderItem < ApplicationRecord
  include MirrorPriceCalculation

  belongs_to :order
  belongs_to :mirror

  before_validation :update_total_price_item

  private

  def update_total_price_item
    update_attributes if new_record?
    update_unit_price
    update_total_price
  end

  def update_attributes # rubocop:disable Metrics/AbcSize
    self.price_square = mirror.price_square
    self.height = mirror.height
    self.width = mirror.width
    self.glass_thickness = mirror.glass_thickness
    self.light = mirror.light
    self.heater = mirror.heater
  end

  def update_unit_price
    self.unit_price = price_calculation
  end

  def update_total_price
    self.total_price_item = unit_price * quantity
  end
end
