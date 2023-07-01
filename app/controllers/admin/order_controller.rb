class Admin::OrderController < ApplicationController
  include Authentication
  include Admin::Concerns::AdminAuthentication
  
  before_action :no_authentication
  before_action :check_admin
  
  def index
    @orders = Order.filter_status(params[:status])
                  .with_field_order(*params[:focus].to_s.split('-'))
                  .find_by_user_phone(params[:phone_number])
  end

  def edit
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @delivery = @order.delivery
  end

  def update
    @order = Order.find(params[:id])
     
    if @order.update(order_params)
      redirect_to edit_admin_order_path(@order)
    else
      render :edit, status: :unprocessable_entity
    end
  end

private
      
  def order_params
    params.require(:order).permit(:status)
  end
  
end

