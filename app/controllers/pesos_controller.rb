class PesosController < ApplicationController
  before_action :set_peso, only: [:show, :edit, :update, :destroy]

  def index
    @pesos = current_user.peso.listar
    @pesos = @pesos.page(params[:page]) unless params[:format].present?

    respond_to do |format|
      format.html
      format.json { render json: @pesos }
      format.pdf do
        pdf = PesosPdf.new(@pesos, Peso)
        send_data pdf.render, filename: (Peso.model_name.human + '.pdf'), disposition: 'inline'
      end
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=#{ t('activerecord.models.peso.other') }.xlsx"
      }
    end
  end

  def new
    ultimo_peso = current_user.peso.select(:altura).order('data DESC').first
    @peso = current_user.peso.new(data: Time.now, altura: (ultimo_peso.altura rescue nil))
  end

  def edit
  end

  def create
    @peso = current_user.peso.build(peso_params)

    if @peso.save
      redirect_to pesos_url, notice: t('mensagens.flash.create')
    else
      render action: :new
    end
  end

  def update
    if @peso.update(peso_params)
      redirect_to pesos_url, notice: t('mensagens.flash.update')
    else
      render action: :edit
    end
  end

  def destroy
    @peso.destroy
    redirect_to pesos_url, notice: t('mensagens.flash.destroy')
  end

  private

    def peso_params
      params[:peso][:altura] = params[:peso][:altura].gsub(',', '.') unless params[:peso][:altura].nil?
      params[:peso][:valor] = params[:peso][:valor].gsub(',', '.') unless params[:peso][:valor].nil?

      params.require(:peso).permit(:altura, :data, :valor)
    end

    def set_peso
      @peso = current_user.peso.find(params[:id])
    end
end
