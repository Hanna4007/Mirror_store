class OrderItemsController < ApplicationController

    def create
        @order = current_order
        @order_item = @order.order_items.new(order_items_params)
       
        @order_item.save
        session[:order_id]=@order.id  
    end


    def update
        @order = current_order
        @order_item = @order.order_items.find(params[:id])

        @order_item.update(order_items_params)
        redirect_to order_path
          
    end


    def destroy
        @order = current_order
        @order_item = @order.order_items.find(params[:id])
        @order_item.destroy
        redirect_to order_path, status: :see_other
    end


    private
    def order_items_params
      params.require(:order_item).permit(:mirror_id, :quantity)
    end


end
