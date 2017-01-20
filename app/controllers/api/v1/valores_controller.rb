class Api::V1::ValoresController < ApplicationController
  include Crud
  before_action :authenticate_with_token!
  before_action :set_valor, only: [:destroy, :show, :update]

  def show
    render json: @valor, status: :ok
  end

  def create
    save_model(Exam.find(params[:exam_id]).valor.new(valor_params))
  end

  def update
    update_model(@valor, valor_params)
  end

  def destroy
    destroy_model(@valor)
  end

  private

  def valor_params
    params.require(:valor).permit(
      :exam_id,
      :gender,
      :idade_inferior,
      :idade_superior,
      :reference_id,
      :valido,
      :valor_inferior,
      :valor_superior)
  end

  def set_valor
    @valor = Exam.find(params[:exam_id]).valor.find(params[:id])
  end
end
