class DeliveriesController < ApplicationController

  include Authentication

  before_action :no_authentication
  
  def new
      current_order
      if @order.order_items.empty?
        redirect_to mirrors_path
        flash[:warning] = 'Your cart is empty. Please add items to your cart before proceeding.'
      else
      @delivery = @order.build_delivery  
    end
  end
  
 def create
    current_order
    @delivery = @order.create_delivery(deliveries_params)
   
    if @delivery.valid?
      redirect_to order_verification_path 
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @delivery = current_order.delivery
  end

  def update
    @delivery = current_order.delivery
    @delivery.update(deliveries_params)
    if @delivery.valid?
      redirect_to order_verification_path 
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def deliveries_params
    params.require(:delivery).permit(:delivery_type, :post, :receiver_name, :receiver_surname, :receiver_phone_number, :city, :region, :receiver_address, :post_office_number)
  end
end
