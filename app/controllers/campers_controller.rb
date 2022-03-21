class CampersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  # GET /campers
  def index
    render json: Camper.all, status: :ok
  end

   # GET /campers/:id
  def show
    camper = Camper.find(params[:id])
    render json: camper, serializer: CamperActivitiesSerializer

  #OR
  # camper = Camper.find_by(id: params[:id])
  #  if camper
  #   render json: camper, status: :ok, serializer: CamperActivitySerializer
  #  else
  #   render json: {errors: "Camper not Found"}
  #  end
  end

  #POST /campers
  def create
    camper = Camper.create!(camper_params)
    render json: camper, status: :created
  end

  # PATCH /campers/:id
  # def update
  # end

  def destroy
    camper = Camper.find(params[:id])
    camper.destroy
    head :no_content
    # render json: {}
  end

  private

  # def find_camper
  #   Camper.find(params[:id])
  # end

  def camper_params
    params.permit(:name, :age)
  end

  def not_found(exception)
    # render json: {errors: exception.message}, status: :not_found
    render json: {"error": "Camper not found"}, status: :not_found
  end

  def handle_invalid_record(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end


end
