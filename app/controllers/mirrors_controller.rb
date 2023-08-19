class MirrorsController < ApplicationController

    def index

      #order = CGI.unescape(params[:order]) if params[:order]
      @mirrors = Mirror.includes(mirror_images_attachments: :blob)
                         .filter_installation(params[:installation])
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
      @order_items = current_order.order_items.new if current_user.present?
    end  
       
end
