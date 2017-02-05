# Class FoodsController
class Api::V1::FoodsController < ApplicationController
  before_action :authenticate_with_token!

  def index
    render json: Food.ordered, adapter: :json,
           each_serializer: FoodSerializer, status: :ok
  end
end
