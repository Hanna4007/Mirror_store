# frozen_string_literal: true

class MirrorCalculationsController < ApplicationController
  def show
    @mirror = Mirror.find(params[:mirror_id])
  end

  def update
    @mirror = Mirror.find(params[:mirror_id])
    @mirror.assign_attributes(mirror_params)
  end

  private

  def mirror_params
    params.require(:mirror).permit(:height, :width, :glass_thickness, :light, :heater)
  end
end
