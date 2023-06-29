class OrderItemsController < ApplicationController
    include Authentication

    before_action :no_user, only: :create
    before_action :no_authentication, exept: :create

    def create
        #if current_user.present?
        @order = current_order
        @order_item = @order.order_items.new(order_items_params)
        @order_item.save
        session[:order_id]=@order.id  
       # else
       # flash[:warning] = 'You aren`t log in!'
       # @mirror = Mirror.find(order_items_params[:mirror_id])
        #@mirror = Mirror.find(mirror_params[:id])
       # redirect_to mirror_path(@mirror)
       # end
    end

    def edit
        @order = current_order
        @order_item = @order.order_items.find(params[:id])

       
    end

    def update
        @order = current_order
        @order_item = @order.order_items.find(params[:id])

        @order_item.update(order_items_params)
        redirect_to order_path(user_id: @user.id)
          
    end


    def destroy
        @order = current_order
        @order_item = @order.order_items.find(params[:id])
        @order_item.destroy
        redirect_to order_path(user_id: @user.id), status: :see_other
    end


    private
    def order_items_params
      params.require(:order_item).permit(:mirror_id, :quantity, :height, :width, :glass_thickness, :light, :heater)
    end

    
end
