class PesosController < ApplicationController
  before_action :set_peso, only: [:show, :edit, :update, :destroy]

  # GET /pesos
  # GET /pesos.json
  def index
    @pesos = current_user.peso.page(params[:page]).order('data DESC, created_at DESC')

    @categories = []
    @maximo = []
    @minimo = []
    @peso = []
    @pesos.reverse.each do |p|
      @categories << l(p.data, format: :default)
      @peso << p.peso
      @maximo << (24.99 * p.altura * p.altura).round(2)
      @minimo << (18.5 * p.altura * p.altura).round(2)
    end
  end

  # GET /pesos/1
  # GET /pesos/1.json
  def show
  end

  # GET /pesos/new
  def new
    ultimo_peso = current_user.peso.select(:altura).order('data DESC').first
    @peso = Peso.new(data: Time.now, altura: (ultimo_peso.altura rescue nil))
  end

  # GET /pesos/1/edit
  def edit
  end

  # POST /pesos
  # POST /pesos.json
  def create
    @peso = current_user.peso.build(peso_params)

    respond_to do |format|
      if @peso.save
        format.html { redirect_to pesos_url, notice: t('mensagens.flash.create', crud: Peso.model_name.human) }
        format.json { render action: 'show', status: :created, location: @peso }
      else
        format.html { render action: 'new' }
        format.json { render json: @peso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pesos/1
  # PATCH/PUT /pesos/1.json
  def update
    respond_to do |format|
      if @peso.update(peso_params)
        format.html { redirect_to pesos_url, notice: t('mensagens.flash.update', crud: Peso.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @peso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pesos/1
  # DELETE /pesos/1.json
  def destroy
    @peso.destroy
    respond_to do |format|
      format.html { redirect_to pesos_url, notice: t('mensagens.flash.destroy', crud: Peso.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_peso
      @peso = current_user.peso.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def peso_params
      params.require(:peso).permit(:altura, :data, :peso)
    end
end