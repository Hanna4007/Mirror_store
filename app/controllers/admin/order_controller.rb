class Admin::OrderController < ApplicationController
  include Authentication
  
  before_action :no_authentication
  before_action :check_admin
  
  def index
    @orders = Order.filter_status(params[:status])
                  .with_field_order(*params[:focus].to_s.split('-'))
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
      
  def check_admin
    unless current_user.admin?
      flash[:warning] = 'You don`t have permission to access this page'
      redirect_to mirrors_path
    end
  end

  def order_params
    params.require(:order).permit(:status)
  end
end

