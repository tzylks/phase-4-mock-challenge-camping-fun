class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :error_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :error_invald
        
    def index
        signups = Signup.all
        render json: signups, status: :ok
    end

    def show
        signup = find_obj
        render json: signup, status: :ok
    end

    def update
        signup = find_obj
        signup.update!(obj_params)
        render json: signup, status: :accepted
    end

    def create
        signup = Signup.create!(obj_params)
        render json: signup.activity, status: :created
    end

    def destroy
        signup = find_obj
        signup.destroy
        head :no_content
    end

    private

    def obj_params
        params.permit(:camper_id, :activity_id, :time)
    end

    def error_not_found
        render json: { error: "Not found" }, status: :not_found
    end

    def error_invald(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end

    def find_obj
        Signup.find(params[:id])
    end
end
