class Admin::InformationsController < ApplicationController

  include Authentication
  include Admin::Concerns::AdminAuthentication

  before_action :no_authentication
  before_action :check_admin

  def edit
    @information = Information.first_or_create
  end

  def update
    @information = Information.first_or_create
    if @information.update(information_params)
      redirect_to mirrors_path
    else
      render :edit
    end
  end

  private

  def information_params
    params.require(:information).permit(:delivery_information, :company_information, :contact_information, :contact_image)
  end

end
