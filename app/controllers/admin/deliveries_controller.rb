class Admin::DeliveriesController < ApplicationController
  include Authentication
  include Admin::Concerns::AdminAuthentication
  
  before_action :no_authentication
  before_action :check_admin
  
  def edit
    @order = Order.find(params[:order_id])
    @delivery = @order.delivery
  end

  def update
    @order = Order.find(params[:order_id])
    @delivery = @order.delivery
    if @delivery.update(deliveries_params)
       redirect_to edit_admin_order_path(@order)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def deliveries_params
    params.require(:delivery).permit(:delivery_type, :post, :receiver_name, :receiver_surname, :receiver_phone_number, :city, :receiver_address, :post_office_number)
  end
end
