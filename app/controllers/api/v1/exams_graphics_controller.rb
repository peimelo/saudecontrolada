class Api::V1::ExamsGraphicsController < ApplicationController
  include Crud
  # before_action :authenticate_with_token!

  def index
    results = ExamResult.graphics(current_user).page(params[:page])
    render json: results, meta: pagination_dict(results), adapter: :json,
           each_serializer: ExamResultGraphicsSerializer, status: :ok
  end

  def show
    results = ExamResult.graphic_values(current_user, params[:id])
    render json: results, adapter: :json,
           each_serializer: GraphicValuesSerializer, status: :ok
  end
end
