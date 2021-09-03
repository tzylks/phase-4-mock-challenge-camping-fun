class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :error_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :error_invald
        
    def index
        campers = Camper.all
        render json: campers, status: :ok
    end

    def show
        camper = find_obj
        render json: camper, status: :ok
    end

    def update
        camper = find_obj
        camper.update!(obj_params)
        render json: camper, status: :accepted
    end

    def create
        camper = Camper.create!(obj_params)
        render json: camper, status: :created
    end

    def destroy
        camper = find_obj
        camper.destroy
        head :no_content
    end

    private

    def obj_params
        params.permit(:name, :age)
    end

    def error_not_found
        render json: { error: "Not found" }, status: :not_found
    end

    def error_invald(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end

    def find_obj
        Camper.find(params[:id])
    end
end
