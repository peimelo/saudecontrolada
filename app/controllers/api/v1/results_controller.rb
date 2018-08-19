# Class ResultsController
class Api::V1::ResultsController < ApplicationController
  include Crud
  # before_action :authenticate_with_token!
  before_action :set_result, only: [:destroy, :show, :update]

  def index
    results = current_user.result.ordered.page(params[:page])
    render json: results, meta: pagination_dict(results), adapter: :json,
           each_serializer: ResultsSerializer, status: :ok
  end

  def show
    render json: @result, status: :ok
  end

  def create
    save_model(current_user.result.new(result_params))
  end

  def update
    update_model(@result, result_params)
  end

  def destroy
    destroy_model(@result)
  end

  private

  def result_params
    params.require(:result).permit(:date, :description)
  end

  def set_result
    @result = current_user.result.find(params[:id])
  end
end
