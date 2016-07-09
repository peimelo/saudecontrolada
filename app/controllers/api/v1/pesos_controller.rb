# Class PesosController
class Api::V1::PesosController < ApplicationController
  include Crud
  before_action :authenticate_with_token!
  before_action :set_peso, only: [:destroy, :show, :update]

  def index
    list_model(current_user.peso_ordered)
  end

  def show
    render json: @peso, status: :ok
  end

  def create
    save_model(current_user.peso.build(peso_params))
  end

  def update
    update_model(@peso, peso_params)
  end

  def destroy
    destroy_model(@peso.destroy)
  end

  private

  def peso_params
    params.require(:peso).permit(:altura, :data, :valor)
  end

  def set_peso
    @peso = current_user.peso.find(params[:id])
  end
end
