class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :error_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :error_invald
        
    def index
        activities = Activity.all
        render json: activities, status: :ok
    end

    def show
        activity = find_obj
        render json: activity, status: :ok
    end

    def update
        activity = find_obj
        activity.update!(obj_params)
        render json: activity, status: :accepted
    end

    def create
        activity = Activity.create!(obj_params)
        render json: activity, status: :created
    end

    def destroy
        activity = find_obj
        activity.destroy
        head :no_content
    end

    private

    def obj_params
        params.permit(:name, :difficulty)
    end

    def error_not_found
        render json: { error: "Activity not found" }, status: :not_found
    end

    def error_invald(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end

    def find_obj
        Activity.find(params[:id])
    end
end
