class Order < ApplicationRecord
    has_many :order_items
    belongs_to :user
    before_save :set_total_price

    VALID_STATUS = ['not paid', 'paid']
    validates :status, inclusion: { in: VALID_STATUS }

    def total_price
        order_items.map{|order_item| order_item.valid? ? order_item.unit_price*order_item.quantity : 0}.sum
    end  
    
    
    private

    def set_total_price
       self.total_price = total_price
    end    
end
