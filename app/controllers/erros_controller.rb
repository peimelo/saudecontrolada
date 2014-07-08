class ErrosController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show]
  skip_before_filter :tem_permissao?
  before_filter :user_administrador?, except: [:show]
  before_filter :get_erro, only: [:edit, :update, :destroy]

  def index
    if params[:erro_status_id].nil?
      @erros = Erro.includes(:erro_status, :recurso).where('erro_status_id <= 1').order('erro_status_id, created_at DESC').page(params[:page])
    else
      @erros = Erro.includes(:erro_status, :recurso).where('erro_status_id = ?', params[:erro_status_id]).order('erro_status_id, created_at DESC').page(params[:page])
    end

    @qtde_erros_por_status = Erro.select('erro_status_id, count(1) as qtde').group('erro_status_id')

    qtde_erros = 0
    @qtde_erros_por_status.each{ |erro| qtde_erros += erro.qtde }
  end

  # esse método irá mostrar a página show com a mensagem de erro capturada em application/erro
  # estou usando a variável session[:temp_msg] para transitar de application_controller
  # para erros_controller. Se o usuário digitar no browser /erros/:id irá mostrar que ele
  # não tem permissão, pois session[:temp_msg] será nula
  def show
    if session[:temp_msg].nil?
      @mensagem = t('mensagens.erros.sem_permissao')
    else
      @mensagem = session[:temp_msg]
      session[:temp_msg] = nil
    end
  end

  def edit
  end

  def update
    # retirando atributos virtuais por causa de erro de ActiveModel::MassAssignmentSecurity::Error
    params[:erro].delete(:condo_nome)
    params[:erro].delete(:created_at)
    params[:erro].delete(:recurso_nome)
    params[:erro].delete(:usuario_nome)

    @erro.update_attributes(erro_params)
    redirect_to erros_url, notice: t('mensagens.flash.update', crud: Erro.model_name.human)
  end

  def destroy
    @erro.destroy

    redirect_to erros_url, notice: t('mensagens.flash.destroy', crud: Erro.model_name.human)
  end

  # -----------------------------------------------------------------------------------------------
  private
    def erro_params
      params.require(:erro).permit(:resolucao, :erro_status_id)
    end
  
    def get_erro
      @erro = Erro.find(params[:id])
    end
end
