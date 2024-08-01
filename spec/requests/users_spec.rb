# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET /new' do
    context 'when current user is not present' do
      it 'renders the new template' do
        get new_user_path
        expect(response).to render_template(:new)
      end
    end

    context 'when current user is present' do
      it 'redirects to mirrors_path with warning message' do
        user = FactoryBot.create(:user)
        login(user)
        get new_user_path
        expect(response).to redirect_to(mirrors_path)
        expect(flash[:warning]).to be_present
      end
    end
  end

  describe 'POST /create' do
    context 'with valid user parameters' do
      let(:valid_params) do
        {
          user: {
            email: 'user_email@gmail.com',
            name: Faker::Internet.username,
            password: '12345678',
            password_confirmation: '12345678',
            admin: false,
            phone_number: "+#{Faker::Number.number(digits: 12)}"
          }
        }
      end
      before do
        post users_path, params: valid_params
      end

      it 'creates a new user' do
        expect(User.last.email).to eq('user_email@gmail.com')
      end

      it 'sets the session user_id' do
        expect(session[:user_id]).to eq(User.last.id)
      end

      it 'redirects to mirrors_path with success message' do
        expect(response).to redirect_to(mirrors_path)
        expect(flash[:success]).to be_present
      end
    end

    context 'with invalid user parameters' do
      let(:invalid_params) do
        {
          user: {
            email: 'invalid_user_email',
            name: 'f',
            password: '1234567',
            password_confirmation: '123456',
            admin: false,
            phone_number: '123'
          }
        }
      end

      before do
        post users_path, params: invalid_params
      end

      it 'does not create a new user' do
        expect(User.last.email).not_to eq('invalid_user_email')
      end

      it 'does not set the session user_id' do
        expect(session[:user_id]).to be_nil
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end
    end

    context 'when current user is present' do
      let(:valid_params) do
        {
          user: {
            email: 'user_email@gmail.com',
            name: Faker::Internet.username,
            password: '12345678',
            password_confirmation: '12345678',
            admin: false,
            phone_number: "+#{Faker::Number.number(digits: 12)}"
          }
        }
      end
      before do
        user = FactoryBot.create(:user)
        login(user)
        post users_path, params: valid_params
      end

      it 'redirects to mirrors_path with warning message' do
        expect(response).to redirect_to(mirrors_path)
        expect(flash[:warning]).to be_present
      end
    end
  end

  describe 'GET /edit' do
    context 'when current user is present' do
      it 'renders the edit template' do
        user = FactoryBot.create(:user)
        login(user)
        get edit_user_path
        expect(response).to render_template(:edit)
      end
    end

    context 'when current user is not present' do
      it 'redirects to mirrors_path with warning message' do
        get edit_user_path
        expect(response).to redirect_to(mirrors_path)
        expect(flash[:warning]).to be_present
      end
    end
  end

  describe 'PATCH /update' do
    let(:valid_params) do
      {
        user: {
          email: 'user_email_1@gmail.com',
          name: Faker::Internet.username,
          password: '12345678',
          password_confirmation: '12345678',
          admin: false,
          phone_number: "+#{Faker::Number.number(digits: 12)}"
        }
      }
    end

    let(:invalid_params) do
      {
        user: {
          email: 'invalid_user_email_1',
          name: 'f',
          password: '1234567',
          password_confirmation: '123456',
          admin: false,
          phone_number: '123'
        }
      }
    end

    let(:user) { FactoryBot.create(:user) }

    context 'with valid user parameters' do
      it 'updates a user' do
        login(user)
        patch user_path, params: valid_params
        user.reload
        expect(user.email).to eq('user_email_1@gmail.com')
      end

      it 'redirects to mirrors_path with success message' do
        login(user)
        patch user_path, params: valid_params
        user.reload
        expect(response).to redirect_to(mirrors_path)
        expect(flash[:success]).to be_present
      end

      it 'redirects to edit_carts_path with success message' do
        login(user)
        patch user_path, params: valid_params.merge(redirect: edit_carts_path)
        user.reload
        expect(response).to redirect_to(edit_carts_path)
        expect(flash[:success]).to be_present
      end
    end

    context 'with invalid user parameters' do
      before do
        login(user)
        patch user_path, params: invalid_params
        user.reload
      end

      it 'does not update a user' do
        expect(user.email).not_to eq('invalid_user_email_1')
      end

      it 'renders the new template' do
        expect(response).to render_template(:edit)
      end
    end

    context 'when current user is not present' do
      it 'redirects to mirrors_path with warning message' do
        patch user_path, params: valid_params
        user.reload
        expect(response).to redirect_to(mirrors_path)
        expect(flash[:warning]).to be_present
      end
    end
  end
end
