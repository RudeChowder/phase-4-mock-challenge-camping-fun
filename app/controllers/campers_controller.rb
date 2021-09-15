class CampersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_error
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error


  def index
    campers = Camper.all
    render json: campers
  end

  def show
    camper = Camper.find(params[:id])
    render json: camper, include: "activities"
  end

  def create
    camper = Camper.create!(camper_params)
    render json: camper, status: :created
  end

private

  def camper_params
    params.permit(:name, :age)
  end

  def render_not_found_error
    render json: { error: "Camper not found" }, status: :not_found
  end

  def render_unprocessable_entity_error(e)
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end
end
