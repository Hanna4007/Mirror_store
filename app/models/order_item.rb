class OrderItem < ApplicationRecord
    belongs_to :order
    belongs_to :mirror
    
    before_validation :update_total_price_item
    
    def calculate_price
      if height==50
        unit_price=(price_square*height*width*0.0001).round
      elsif height==80
        unit_price=(price_square*height*width*0.0001*1.15).round
      else
        unit_price=(price_square*height*width*0.0001*1.3).round
      end

      if glass_thickness==6
        unit_price+=635
      else
        unit_price
      end
  
      if heater==true
        unit_price+=1110
      else
        unit_price
      end 
  
    end
   
    private

    def update_total_price_item
      
      self.price_square = mirror.price_square if new_record?
      self.height = mirror.height if new_record?
      self.width = mirror.width if new_record?
      self.glass_thickness = mirror.glass_thickness if new_record?
      self.light = mirror.light if new_record?
      self.heater = mirror.heater if new_record?
      self.unit_price = calculate_price
      self.total_price_item = unit_price*quantity
        
    end
end
