# Class ResultsController
class Api::V1::ResultsController < ApplicationController
  include Crud
  before_action :authenticate_with_token!
  before_action :admin?, except: :index
  before_action :set_result, only: [:destroy, :show, :update]

  def index
    list_model(Result.ordered)
  end

  def show
    render json: @result, status: :ok
  end

  def create
    save_model(Result.new(result_params))
  end

  def update
    update_model(@result, result_params)
  end

  def destroy
    destroy_model(@result)
  end

  private

  def result_params
    params.require(:result).permit(:name)
  end

  def set_result
    @result = Result.find(params[:id])
  end
end
