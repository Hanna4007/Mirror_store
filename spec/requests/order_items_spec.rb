require 'rails_helper'

RSpec.describe "OrderItems", type: :request do
  describe "POST /create order_item" do
      let(:mirror_1) { FactoryBot.create(:mirror) }
      let(:user_1) { FactoryBot.create(:user) }

    context 'when current user is present' do
      before do
        login(user_1)
        post order_items_path, params: { order_item: { mirror_id: mirror_1.id, quantity: 2 }}
      end

      it 'returns a success HTTP status' do
        expect(response).to have_http_status(204)
      end
      
      it 'creates an order item' do
        expect(OrderItem.count).to eq(1) 
        expect(OrderItem.last.mirror_id).to eq(mirror_1.id) 
      end

      it 'sets the session order_id' do
        expect(session[:order_id]).to eq(assigns(:current_order).id)
      end
    end

    context 'when current user is not present' do         
      it 'creates an order item when ' do
        post order_items_path, params: { order_item: { mirror_id: mirror_1.id, quantity: 2 }}
        expect(response).to redirect_to(mirror_path(assigns(:mirror)))   
        expect(flash[:warning]).to be_present  
      end
    end
  end  
end
