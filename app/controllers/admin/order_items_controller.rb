class Admin::OrderItemsController < ApplicationController
  include Authentication
  
  before_action :no_authentication
  before_action :check_admin
  before_action :check_status, only: [:update, :destroy]
   
  def edit
    @order = Order.find(params[:order_id])
    @order_item = @order.order_items.find(params[:id])
  end

  def update
    @order = Order.find(params[:order_id])
    @order_item = @order.order_items.find(params[:id])

    if @order_item.update(order_item_params)
      redirect_to edit_admin_order_path(@order)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order = Order.find(params[:order_id])
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    redirect_to edit_admin_order_path(@order), status: :see_other
end

  private
      
  def check_status
    @order = Order.find(params[:order_id])
    unless ['in progress', 'confirmed', 'waiting for payment'].include?(@order.status) 
      flash[:warning] = 'The order has already been paid. It cannot be changed.'
      redirect_to edit_admin_order_path(@order)
    end
  end

  def check_admin
    unless current_user.admin?
      flash[:warning] = 'You don`t have permission to access this page'
      redirect_to mirrors_path
    end
  end

  def order_item_params
    params.require(:order_item).permit(:quantity, :height, :width, :glass_thickness, :light, :heater)
  end
end