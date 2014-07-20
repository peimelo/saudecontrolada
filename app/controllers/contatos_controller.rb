class ContatosController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  skip_before_action :tem_permissao?
  before_action :user_administrador?, only: [:index]
  
  helper_method :sort_column, :sort_direction

  def index
    @contatos = Contato.order(sort_column + ' ' + sort_direction).page(params[:page])
  end

  def new
    @contato = Contato.new
    @contato.email = current_user.email unless current_user.blank?
  end

  def create
    @contato = Contato.new(contato_params)
    @contato.ip = request.remote_ip
    
    if @contato.save
      #TODO: avaliar qual background usar
      MailNotifier.delay.contato(@contato)
      redirect_to new_contato_url, notice: t('mensagens.contato_enviado')
    else
      render :new
    end
  end
  
  private
    def contato_params
      params.require(:contato).permit(:email, :mensagem, :nome, :telefones)
    end
    
    def sort_column
      Contato.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
    end
end
