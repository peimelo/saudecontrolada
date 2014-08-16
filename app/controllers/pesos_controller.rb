class PesosController < ApplicationController
  helper_method :sort_column, :sort_direction

  before_action :set_peso, only: [:show, :edit, :update, :destroy]

  before_action ->(texto=t('activerecord.models.peso.other'), url=resultados_path) {
    add_crumb(texto, url) }, except: [:index, :destroy]
  before_action ->(texto=t('views.edit.titulo', model: Peso.model_name.human), url=edit_peso_path(@peso)) {
    add_crumb(texto, url) }, only: [:edit, :update]
  before_action ->(texto=t('views.new.titulo', model: Peso.model_name.human), url=new_peso_path) {
    add_crumb(texto, url) }, only: [:new, :create]

  def index
    if params[:format].nil?
      @pesos = current_user.peso.page(params[:page]).order(sort_column + ' ' + sort_direction)
    else
      @pesos = current_user.peso.order(sort_column + ' ' + sort_direction)
    end

    # categories = []
    # maximo = []
    # minimo = []
    # peso = []
    # @pesos.reverse.each do |p|
    #   categories << l(p.data, format: :default)
    #   peso << p.peso.to_f
    #   maximo << (24.99 * p.altura * p.altura).round(2).to_f
    #   minimo << (18.5 * p.altura * p.altura).round(2).to_f
    # end
    #
    # @chart = LazyHighCharts::HighChart.new('graph') do |f|
    #   f.xAxis(categories: categories, labels: { enabled: false })
    #
    #   f.title(text: 'Peso por Data')
    #   f.tooltip(valueSuffix: ' Kg')
    #
    #   f.series(name: 'Limite Máximo', data: maximo, color: '#8a403b')
    #   f.series(name: 'Peso', data: peso)
    #   f.series(name: 'Limite Mínimo', data: minimo, color: '#b02e25')
    #
    #   f.legend(align: 'center', borderWidth: 1, layout: 'horizontal')
    #
    #   f.plotOptions(line: { lineWidth: 4, marker: { enabled: false } })
    # end

    respond_to do |format|
      format.html
      format.pdf do
        pdf = PesosPdf.new(@pesos, Peso)
        send_data pdf.render, filename: (Peso.model_name.human + '.pdf'), disposition: 'inline'
      end
      format.xls
    end
  end

  def new
    ultimo_peso = current_user.peso.select(:altura).order('data DESC').first
    @peso = Peso.new(data: Time.now, altura: (ultimo_peso.altura rescue nil))
  end

  def edit
  end

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

  def destroy
    @peso.destroy
    respond_to do |format|
      format.html { redirect_to pesos_url, notice: t('mensagens.flash.destroy', crud: Peso.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def peso_params
      params.require(:peso).permit(:altura, :data, :peso)
    end

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