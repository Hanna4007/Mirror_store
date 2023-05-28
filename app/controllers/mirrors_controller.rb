class MirrorsController < ApplicationController

    def index

      order = CGI.unescape(params[:order]) if params[:order]

        @mirrors = Mirror.filter_installation(params[:installation])
                         .filter_lamp(params[:lamp])
                         .with_field_order(*params[:order].to_s.split('-'))
                         #params[:order] = 'price+asc'
                         #params[:order].split # ['price', 'asc']
                         #with_field_order(['price', 'asc'])
                         #with_field_order(*['price', 'asc'])
                         #with_field_order('price', 'asc')
                         
       # @order_mirrors = @mirrors.order_price
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
          #render :edit, status: :unprocessable_entity
          redirect_to mirror_path(@mirror)
          
          else
          render :edit, status: :unprocessable_entity
          
        end
    end
    
    def destroy
        @mirror = Mirror.find(params[:id])
        @mirror.destroy
        redirect_to mirrors_path, status: :see_other
    end

    #def installation_wall
    #  @mirrors = Mirror.all
    #  @installation_wall_mirrors = @mirrors.filter_installation_wall
    #end

    #def installation_table
    #  @mirrors = Mirror.all
    #  @installation_table_mirrors = @mirrors.filter_installation_table
    #end
  
     
    private
      def mirror_params
        params.require(:mirror).permit(:name, :height, :width, :glass_thickness, :light, :heater, :price, :price_square, :installation, :lamp, mirror_images: [])
      end


end
