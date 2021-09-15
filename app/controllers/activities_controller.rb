class ActivitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error

  def index
    activities = Activity.all
    render json: activities
  end

  def destroy
    activity = Activity.find(params[:id])
    activity.destroy
    head :ok
  end

private

  def render_not_found_error
    render json: { error: "Activity not found" }, status: :not_found
  end
end
