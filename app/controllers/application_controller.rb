# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user, :current_order

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

  def current_order
    @current_order ||= (session[:order_id].nil? ? session_order_id_present : session_order_id_absent)
  end

  def session_order_id_present
    order = current_user.orders.last
    order&.status == 'in progress' ? order : current_user.orders.new
  end

  def session_order_id_absent
    current_user.orders.find_by(id: session[:order_id]) || current_user.orders.new
  end
end
