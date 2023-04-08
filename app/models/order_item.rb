class OrderItem < ApplicationRecord
    belongs_to :order
    belongs_to :mirror

    before_save :set_unit_price
    before_save :set_total_price_item


    def unit_price
        if persisted?
            self[:unit_price]
        else
            mirror.price   
        end 
    end


    def total_price_item 
        unit_price*quantity
    end 
    
    
    private

    def set_unit_price 
        self[:unit_price] = unit_price
    end    

    def set_total_price_item 
        self[:total_price_item] = total_price_item
    end  


end
