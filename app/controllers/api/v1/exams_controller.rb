class Api::V1::ExamsController < ApplicationController
  include Crud
  before_action :authenticate_with_token!
  before_action :set_exam, only: [:destroy, :show, :update]

  def index
    if params[:page]
      list_model(Exam.ordered)
    else
      render json: Exam.ordered, adapter: :json,
             each_serializer: ExamSerializer, status: :ok
    end
  end

  def show
    render json: @exam, adapter: :json,
           serializer: ExamDetailSerializer, status: :ok
  end

  def create
    save_model(Exam.new(exam_params))
  end

  def update
    update_model(@exam, exam_params)
  end

  def destroy
    destroy_model(@exam.destroy)
  end

  private

  def exam_params
    params.require(:exam).permit(:name, :unit_id)
  end

  def set_exam
    @exam = Exam.find(params[:id])
  end
end
