# Class UnitsController
class Api::V1::UnitsController < ApplicationController
  include Crud
  before_action :authenticate_with_token!
  before_action :admin?
  before_action :set_unit, only: [:destroy, :show, :update]

  def index
    if params[:page]
      list_model(Unit.ordered)
    else
      render json: Unit.ordered, adapter: :json,
             each_serializer: UnitSerializer, status: :ok
    end
  end

  def show
    render json: @unit, status: :ok
  end

  def create
    save_model(Unit.new(unit_params))
  end

  def update
    update_model(@unit, unit_params)
  end

  def destroy
    destroy_model(@unit)
  end

  private

  def unit_params
    params.require(:unit).permit(:name)
  end

  def set_unit
    @unit = Unit.find(params[:id])
  end
end
