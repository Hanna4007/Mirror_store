module ApplicationHelper
  def current_order
    @user = current_user
    @order ||= if !session[:order_id].nil?
      current_user.orders.find_by(id: session[:order_id]) || current_user.orders.new
    else
      order = current_user.orders.last
      order&.status =='in progress' ? order : current_user.orders.new
    end
  end
end
    
