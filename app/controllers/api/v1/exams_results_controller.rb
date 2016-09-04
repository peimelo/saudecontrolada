class Api::V1::ExamsResultsController < ApplicationController
  include Crud
  before_action :authenticate_with_token!
  before_action :set_exam_result, only: [:destroy, :show, :update]

  def show
    render json: @exam_result, status: :ok
  end

  def create
    save_model(current_user.exam_result.new(exam_result_params))
  end

  def update
    update_model(@exam_result, exam_result_params)
  end

  def destroy
    destroy_model(@exam_result)
  end

  private

  def exam_result_params
    params.require(:exam_result).permit(:date, :description)
  end

  def set_exam_result
    @exam_result = current_user
                     .result.find(params[:result_id])
                     .exam_result.find(params[:id])
  end
end
