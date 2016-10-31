class Api::V1::ResultsGraphicsController < ApplicationController
  include Crud
  before_action :authenticate_with_token!

  def index
    results = ExamResult.graphics(current_user).page(params[:page])
    render json: results, meta: pagination_dict(results), adapter: :json,
           each_serializer: ExamResultGraphicsSerializer, status: :ok
  end
end
