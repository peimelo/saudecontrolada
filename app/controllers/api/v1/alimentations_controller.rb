class Api::V1::AlimentationsController < ApplicationController
  include Crud
  before_action :authenticate_with_token!
  before_action :set_alimentation, only: [:destroy, :show, :update]

  def index
    list_model(current_user.alimentation_ordered)
  end

  def show
    render json: @alimentation, status: :ok
  end

  def create
    save_model(current_user.alimentation.build(alimentation_params))
  end

  def update
    update_model(@alimentation, alimentation_params)
  end

  def destroy
    destroy_model(@alimentation)
  end

  private

  def alimentation_params
    params.require(:alimentation).permit(:date, :meal_id)
  end

  def set_alimentation
    @alimentation = current_user.alimentation.find(params[:id])
  end
end
