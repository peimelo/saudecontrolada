class Api::V1::ExamsResultsController < ApplicationController
  include Crud
  before_action :authenticate_with_token!
  before_action :set_exam_result, only: [:destroy, :show, :update]

  def index
    list_model(current_user.result.find(params[:result_id]).exam_result.ordered)
  end

  def show
    render json: @exam_result, status: :ok
  end

  def create
    save_model(current_user.result.find(params[:result_id]).exam_result.new(exam_result_params))
  end

  def update
    update_model(@exam_result, exam_result_params)
  end

  def destroy
    destroy_model(@exam_result)
  end

  private

  def exam_result_params
    params.require(:exams_result).permit(:value, :exam_id, :result_id)
  end

  def set_exam_result
    @exam_result = current_user
                     .result.find(params[:result_id])
                     .exam_result.find(params[:id])
  end
end
