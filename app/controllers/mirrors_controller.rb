class MirrorsController < ApplicationController

    def index
        @mirrors = Mirror.all
    end
    
    def show
        @mirror = Mirror.find(params[:id])
        @order_items = current_order.order_items.new
    end  
       
    def new
        @mirror = Mirror.new
    end
    
    def create
        @mirror = Mirror.new(mirror_params)
        if @mirror.save
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
          render :edit, status: :unprocessable_entity
          #redirect_to mirrors_path
          else
          render :edit, status: :unprocessable_entity
        end
    end
    
    def destroy
        @mirror = Mirror.find(params[:id])
        @mirror.destroy
        redirect_to mirrors_path, status: :see_other
    end
       
    private
      def mirror_params
        params.require(:mirror).permit(:name, :height, :width, :glass_thickness, :light, :heater, :price, :price_square, mirror_images: [] )
      end


end
