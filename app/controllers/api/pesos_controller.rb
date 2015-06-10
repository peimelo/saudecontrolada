class API::PesosController < ApplicationController
  skip_before_filter :authenticate_user!

  # GET /pesos
  # GET /pesos.json
  def index
    user = User.find_by_email('peimelo@gmail.com')
    render json: user.peso.all
  end

  # GET /pesos/1
  # GET /pesos/1.json
  def show
    @peso = Peso.find(params[:id])

    render json: @peso
  end

  # POST /pesos
  # POST /pesos.json
  def create
    @peso = Peso.new(peso_params)

    if @peso.save
      render json: @peso, status: :created, location: @peso
    else
      render json: @peso.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pesos/1
  # PATCH/PUT /pesos/1.json
  def update
    @peso = Peso.find(params[:id])

    if @peso.update(peso_params)
      head :no_content
    else
      render json: @peso.errors, status: :unprocessable_entity
    end
  end

  # DELETE /pesos/1
  # DELETE /pesos/1.json
  def destroy
    @peso = Peso.find(params[:id])
    @peso.destroy

    head :no_content
  end

  private

  def peso_params
    params[:peso]
  end
end