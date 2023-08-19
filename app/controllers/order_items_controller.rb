class OrderItemsController < ApplicationController
    include Authentication

    before_action :no_user, only: :create
    before_action :no_authentication, exept: :create

    def create
        @order_item = current_order.order_items.new(order_items_params)
        @order_item.save
        session[:order_id]=current_order.id  
    end

    def edit
        @order_item = current_order.order_items.find(params[:id])
    end

    def update
        @order_item = current_order.order_items.find(params[:id])
        @delivery = current_order.delivery

        @order_item.update(order_items_params)
        if @delivery.present? 
          redirect_to edit_carts_path
        else 
          redirect_to carts_path
        end
          
    end


    def destroy
        @order_item = current_order.order_items.find(params[:id])
        @order_item.destroy
        redirect_to carts_path, status: :see_other
    end


    private
    def order_items_params
      params.require(:order_item).permit(:mirror_id, :quantity, :height, :width, :glass_thickness, :light, :heater)
    end

    
end
