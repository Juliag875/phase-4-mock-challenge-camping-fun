class SignupsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

  def create
    signup = Signup.create!(signup_params)
    render json: signup.activity, status: :created
  end

  # if signup.valid? 
  #   render json: signup.activity, status: :ok
  # else 
  #   render json: {errors: signup.errors.full_messages}, status: :uprocessable_entity
  # end 

  private

  def signup_params
    params.permit(:camper_id, :activity_id, :time)
  end

  def handle_invalid_record(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end
end
