class InformationsController < ApplicationController
    def delivery_information
      @information = Information.first
      @delivery_information = @information.delivery_information
    end
    
    def company_information
      @information = Information.first
      @company_information = @information.company_information
    end

    def contact_information
        @information = Information.first
        @contact_information = @information.contact_information
    end

end
