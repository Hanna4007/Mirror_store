class Admin::MirrorsController < ApplicationController
  include Authentication
  include Admin::Concerns::AdminAuthentication

  before_action :no_authentication
  before_action :check_admin

  def new
    @mirror = Mirror.new
  end
    
  def create
    @mirror = Mirror.new(mirror_params)

    if @mirror.save
      flash[:success] = 'Mirror created'
      redirect_to mirrors_path
    else
      render :new, status: :unprocessable_entity
    end
  end
    
  def edit
    @mirror = Mirror.find(params[:id])
  end
    
  def update
    @mirror = Mirror.find(params[:id])

    if @mirror.update(mirror_params)
      flash[:success] = 'Mirror updated'
      redirect_to mirror_path(@mirror)
    else
      render :edit, status: :unprocessable_entity
    end
  end
    
  def destroy
    @mirror = Mirror.find(params[:id])
    @mirror.destroy
    flash[:success] = 'Mirror deleted'
    redirect_to mirrors_path, status: :see_other
  end

private
  def mirror_params
    params.require(:mirror).permit(:name, :height, :width, :glass_thickness, :light, :heater, :price, :price_square, :installation, :lamp, :description, mirror_images: [])
  end

end
