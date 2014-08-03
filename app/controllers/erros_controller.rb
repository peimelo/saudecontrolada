class ErrosController < ApplicationController
  helper_method :sort_column, :sort_direction

  skip_before_filter :authenticate_user!, only: [:show]
  skip_before_filter :tem_permissao?
  before_filter :user_administrador_sistema?, except: [:show]
  before_filter :get_erro, only: [:edit, :update, :destroy]

  def index
    if params[:erro_status_id].nil?
      @erros = Erro.listar(params[:page], sort_column + ' ' + sort_direction)
    else
      @erros = Erro.listar_por_status(params[:erro_status_id], params[:page], sort_column + ' ' + sort_direction)
    end

    @qtde_erros_por_status = Erro.qtde_erros_por_status
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

  private
    def erro_params
      params.require(:erro).permit(:resolucao, :erro_status_id)
    end
  
    def get_erro
      @erro = Erro.find(params[:id])
    end

  def sort_column
    Erro.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end
end
