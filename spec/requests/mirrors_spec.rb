require 'rails_helper'

RSpec.describe "Mirrors", type: :request do
  describe "GET /index" do
    let!(:mirror_1) { FactoryBot.create(:mirror) }
    let!(:mirror_2) { FactoryBot.create(:mirror) }
    
    it 'displays a list of mirrors' do
      get mirrors_path
      expect(response).to have_http_status(200)
      expect(response.body).to include(mirror_1.name) 
      expect(response.body).to include(mirror_2.name) 
    end
  end

  describe "GET /show" do
    let(:mirror_1) { FactoryBot.create(:mirror) }
       
    it 'renders the show template' do
      get mirror_path(mirror_1)
      expect(response).to render_template('show') 
      expect(response.body).to include(mirror_1.name) 
    end
  end

  describe "POST /create order_item" do
    let(:mirror_1) { FactoryBot.create(:mirror) }
    let(:user_1) { FactoryBot.create(:user) }
       
    it 'renders the show template and creates an order item' do
      login(user_1)
      get mirror_path(mirror_1)
      post order_items_path, params: { order_item: { mirror_id: mirror_1.id, quantity: 2 }}
      expect(OrderItem.count).to eq(1) 
      expect(OrderItem.last.mirror_id).to eq(mirror_1.id) 
    end
  end
end
