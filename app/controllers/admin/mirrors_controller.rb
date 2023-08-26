# frozen_string_literal: true

module Admin
  class MirrorsController < ApplicationController
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
        redirect_to mirrors_path, flash: { success: I18n.t('mirror_created') }
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
        redirect_to mirror_path(@mirror), flash: { success: I18n.t('mirror_updated') }
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @mirror = Mirror.find(params[:id])
      @mirror.destroy
      redirect_to mirrors_path, status: :see_other, flash: { success: I18n.t('mirror_deleted') }
    end

    private

    def mirror_params
      params.require(:mirror).permit(:name, :height, :width, :glass_thickness, :light, :heater, :price_square,
                                     :installation, :lamp, :description, mirror_images: [])
    end
  end
end
