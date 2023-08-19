class OrderItem < ApplicationRecord
  include MirrorPriceCalculation

    belongs_to :order
    belongs_to :mirror
    
    before_validation :update_total_price_item
    
  private

    def update_total_price_item
       if new_record?
      self.price_square = mirror.price_square 
      self.height = mirror.height 
      self.width = mirror.width 
      self.glass_thickness = mirror.glass_thickness 
      self.light = mirror.light 
      self.heater = mirror.heater 
       end
      self.unit_price = price_calculation
      self.total_price_item = unit_price*quantity
        
    end
end
