# Class DashboardsController
class Api::V1::DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @dashboard = Dashboard.new(current_user)
    render json: @dashboard, status: :ok
  end
end
