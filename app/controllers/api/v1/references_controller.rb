# Class ReferencesController
class Api::V1::ReferencesController < ApplicationController
  include Crud
  before_action :authenticate_with_token!
  before_action :admin?
  before_action :set_reference, only: [:destroy, :show, :update]

  def index
    if params[:page]
      list_model(Reference.ordered)
    else
      render json: Reference.ordered, adapter: :json,
             each_serializer: ReferenceSerializer, status: :ok
    end
  end

  def show
    render json: @reference, status: :ok
  end

  def create
    save_model(Reference.new(reference_params))
  end

  def update
    update_model(@reference, reference_params)
  end

  def destroy
    destroy_model(@reference)
  end

  private

  def reference_params
    params.require(:reference).permit(:name)
  end

  def set_reference
    @reference = Reference.find(params[:id])
  end
end
