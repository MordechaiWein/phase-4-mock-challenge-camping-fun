class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_camper_errors
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    def index 
        render :json => Camper.all
    end

    def show
        camper = Camper.find(params[:id])
        render :json => camper, serializer: CustomCamperSerializer
    end

    def create
        camper = Camper.create!(camper_params)
        render :json => camper, status: :created
    end

    private

    def camper_params
        params.permit(:name, :age)
    end

    def render_camper_errors(instance)
        render :json => {errors: instance.record.errors.full_messages}, status: :unprocessable_entity
    end

    def render_not_found
        render :json => {"error": "Camper not found"}, status: :not_found
    end

end
