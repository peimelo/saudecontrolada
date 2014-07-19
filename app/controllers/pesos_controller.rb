class PesosController < ApplicationController
  helper_method :sort_column, :sort_direction

  before_action :set_peso, only: [:show, :edit, :update, :destroy]

  # GET /pesos
  # GET /pesos.json
  def index
    @pesos = current_user.peso.page(params[:page]).order(sort_column + ' ' + sort_direction)

    categories = []
    maximo = []
    minimo = []
    peso = []
    @pesos.reverse.each do |p|
      categories << l(p.data, format: :default)
      peso << p.peso.to_f
      maximo << (24.99 * p.altura * p.altura).round(2).to_f
      minimo << (18.5 * p.altura * p.altura).round(2).to_f
    end

    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.xAxis(categories: categories, labels: { step: categories.size/3 })

      f.title(text: 'Evolução do Peso por Data')
      f.tooltip(valueSuffix: ' Kg')

      f.series(name: 'Limite Máximo', data: maximo, color: '#8a403b')
      f.series(name: 'Peso', data: peso)
      f.series(name: 'Limite Mínimo', data: minimo, color: '#b02e25')

      f.legend(align: 'center', borderWidth: 1, layout: 'horizontal')

      f.plotOptions(line: { lineWidth: 4, marker: { enabled: false } })
    end

    respond_to do |format|
      format.html
      format.pdf do
        pdf = PesosPdf.new(@pesos, Peso)
        send_data pdf.render, filename: (Peso.model_name.human + '.pdf'), disposition: 'inline'
      end
      format.xls
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
    # Never trust parameters from the scary internet, only allow the white list through.
    def peso_params
      params.require(:peso).permit(:altura, :data, :peso)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_peso
      @peso = current_user.peso.find(params[:id])
    end

    def sort_column
      Peso.column_names.include?(params[:sort]) ? params[:sort] : 'data'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end
end