class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_errors

    def create
        signup = Signup.create!(signup_params)
        render :json => signup.activity, status: :created
    end

    private 

    def signup_params
        params.permit(:time, :camper_id, :activity_id)
    end

    def render_errors(instance)
        render :json => {errors: instance.record.errors.full_messages}, status: :unprocessable_entity
    end

end
