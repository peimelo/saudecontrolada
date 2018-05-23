# Class MealsController
class Api::V1::MealsController < ApplicationController
  # before_action :authenticate_with_token!

  def index
    render json: Meal.ordered, adapter: :json, status: :ok
  end
end
