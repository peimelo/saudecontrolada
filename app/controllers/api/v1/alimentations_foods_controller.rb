class Api::V1::AlimentationsFoodsController < ApplicationController
  include Crud
  # before_action :authenticate_with_token!
  before_action :set_alimentation_food, only: [:destroy, :show, :update]

  def index
    list_model(current_user.alimentation.find(params[:alimentation_id])
                 .alimentation_food.ordered)
  end

  def show
    render json: @alimentation_food, status: :ok
  end

  def create
    save_model(current_user.alimentation.find(params[:alimentation_id])
                .alimentation_food.new(alimentation_food_params))
  end

  def update
    update_model(@alimentation_food, alimentation_food_params)
  end

  def destroy
    destroy_model(@alimentation_food)
  end

  private

  def alimentation_food_params
    params.require(:alimentations_food).permit(:value, :alimentation_id, :food_id)
  end

  def set_alimentation_food
    @alimentation_food = current_user
                           .alimentation.find(params[:alimentation_id])
                           .alimentation_food.find(params[:id])
  end
end
