# frozen_string_literal: true

module Admin
  class OrderItemsController < ApplicationController
    include Authentication
    include Admin::Concerns::AdminAuthentication

    before_action :no_authentication
    before_action :check_admin
    before_action :check_status, only: %i[update destroy]

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

    def order_item_params
      params.require(:order_item).permit(:quantity, :height, :width, :glass_thickness, :light, :heater)
    end

    def check_status
      @order = Order.find(params[:order_id])
      return if ['in progress', 'confirmed', 'waiting for payment'].include?(@order.status)

      redirect_to edit_admin_order_path(@order), flash: { warning: I18n.t('order_has_been_paid') }
    end
  end
end
