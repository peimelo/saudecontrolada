class ContatosController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  skip_before_action :tem_permissao?
  before_action :user_administrador_sistema?, only: [:index]

  def index
    @contatos = Contato.order(created_at: :desc).page(params[:page])
  end

  def new
    @contato = Contato.new
    @contato.email = current_user.email unless current_user.blank?
  end

  def create
    @contato = Contato.new(contato_params)
    @contato.ip = request.remote_ip
    
    if @contato.save
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
end
