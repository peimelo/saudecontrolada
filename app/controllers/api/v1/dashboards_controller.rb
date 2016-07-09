# Class DashboardsController
class Api::V1::DashboardsController < ApplicationController
  include Crud
  before_action :authenticate_with_token!

  def show
    @dashboard = Dashboard.new(current_user)
    render json: @dashboard, status: :ok
  end
end
