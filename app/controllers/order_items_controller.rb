class OrderItemsController < ApplicationController
    include Authentication

    before_action :no_user, only: :create
    before_action :no_authentication, exept: :create

    def create
        @order = current_order
        @order_item = @order.order_items.new(order_items_params)
        @order_item.save
        session[:order_id]=@order.id  
    end

    def edit
        @order = current_order
        @order_item = @order.order_items.find(params[:id])
    end

    def update
        @order = current_order
        @order_item = @order.order_items.find(params[:id])
        @delivery = @order.delivery

        @order_item.update(order_items_params)
        if @delivery.present? 
          redirect_to order_verification_path
        else 
        redirect_to order_path
        end
          
    end


    def destroy
        @order = current_order
        @order_item = @order.order_items.find(params[:id])
        @order_item.destroy
        redirect_to order_path, status: :see_other
    end


    private
    def order_items_params
      params.require(:order_item).permit(:mirror_id, :quantity, :height, :width, :glass_thickness, :light, :heater)
    end

    
end
