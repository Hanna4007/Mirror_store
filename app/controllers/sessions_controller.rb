# frozen_string_literal: true

class SessionsController < ApplicationController
  include Authentication

  before_action :authentication, only: %i[new create]
  before_action :no_authentication, only: %i[destroy]

  def new; end

  def create
    user = create_session
    if user.present?
      successful_login(user)
    else
      unsuccessful_login
    end
  end

  def destroy
    session.delete(:order_id)
    session.delete(:user_id)
    redirect_to mirrors_path
  end

  private

  def create_session
    user_params = params.require(:session)
    User.find_by(email: user_params[:email])&.authenticate(user_params[:password])
  end

  def successful_login(user)
    session[:user_id] = user.id
    redirect_to mirrors_path, flash: { success: I18n.t('welcome_user', name: user.name) }
  end

  def unsuccessful_login
    flash.now[:warning] = I18n.t('invalid_email_or_password')
    render :new
  end
end
