class MirrorCalculationsController < ApplicationController
    
  def count
    @mirror = Mirror.find(params[:id])
  end

  def count_assign
    @mirror = Mirror.find(params[:id])
    @mirror.assign_attributes(mirror_params)
  end
    
    
    
    #def count

       # @mirror = Mirror.find(params[:id])
       # if @mirror.assign_attributes(mirror_params)
       #   render '/mirrors/:id/calculation'
          #redirect_to mirrors_path
       #   else
          #render '/mirrors/:id/calculation'
        #  redirect_to mirrors_path
       # end
   # end

    private
    def mirror_params
        params.require(:mirror).permit(:height, :width, :glass_thickness, :light, :heater)
    end

end
