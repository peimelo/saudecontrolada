class Api::V1::WeightsController < ApplicationController
  include Crud
  before_action :authenticate_with_token!
  before_action :set_weight, only: [:destroy, :show, :update]

  def index
    list_model(current_user.weight_ordered)
  end

  def show
    render json: @weight, status: :ok
  end

  def create
    save_model(current_user.weight.build(weight_params))
  end

  def update
    update_model(@weight, weight_params)
  end

  def destroy
    destroy_model(@weight.destroy)
  end

  private

  def weight_params
    params.require(:weight).permit(:date, :height, :value)
  end

  def set_weight
    @weight = current_user.weight.find(params[:id])
  end
end
