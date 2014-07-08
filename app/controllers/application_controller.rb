class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # captura todos os erros, essa é a classe pai de todos os erros
  rescue_from StandardError, with: :erro if Rails.env == 'production'

  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :date_of_birth, :gender) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password, :date_of_birth, :gender) }
    end

  private
    def erro(exception=nil)
      logger.warn '##########################################################'
      logger.warn '1##### Entrou no erro'
      get_recurso()
      logger.warn "2##### Recurso: #{@recurso.controlador.nome} / #{@recurso.acao.nome}" rescue "recurso = erro"

      if exception.nil?
        nome_erro = I18n.t('mensagens.erros.sem_permissao')
        descricao_erro = params
      else
        nome_erro = exception.class.to_s.gsub('::', ' :: ') # caso visualize por celular ter quebra de linha
        descricao_erro = exception.to_s
      end
      logger.warn "3##### Erro: #{nome_erro}" rescue 'erro = erro'
      logger.warn "4##### Descricao do erro: #{descricao_erro}" rescue 'descricao = erro'
      logger.warn "5##### Dispositivo: #{request.user_agent.to_s}" rescue 'dispositivo = erro'
      logger.warn "6##### condo_id: #{session[:condo_id]}" rescue 'condo_id = erro'
      logger.warn "7##### ip: #{request.remote_ip}" rescue 'remote_id = erro'
      logger.warn "8##### user_id: #{current_user.id}" rescue 'user_id = erro'
      logger.warn "9##### user_email: #{current_user.email}" rescue 'user_email = erro'
      logger.warn '##########################################################'

      # para não aparecer sempre o erro genérico, ao ir aparecendo erros comuns
      # vamos mapeando para mostrar uma msg de erro mais direcionada.
      case nome_erro
        when 'ActionController :: RoutingError'
          session[:temp_msg] = I18n.t('mensagens.erros.pagina_nao_encontrada')
        when 'ActiveRecord :: RecordNotFound'
          if descricao_erro == "Couldn't find Condo without an ID"
            flash[:alert] = I18n.t('mensagens.erros.selecione_condominio')
            redirect_to condos_path
            return
          else
            session[:temp_msg] = I18n.t('mensagens.erros.registro_nao_encontrado')
          end
        when I18n.t('mensagens.erros.sem_permissao')
          session[:temp_msg] = I18n.t('mensagens.erros.sem_permissao')
        when 'ActiveRecord :: StatementInvalid'
          session[:temp_msg] = I18n.t('mensagens.erros.banco_dados')
        else
          session[:temp_msg] = I18n.t('mensagens.erros.generico')
      end

      # usando @erro ao invés de erro, porque é capturado no RSpec
      @erro = Erro.create(
          :condo_id => session[:condo_id],
          :descricao => descricao_erro,
          :dispositivo => request.user_agent.to_s,
          :ip => request.remote_ip,
          :nome => nome_erro,
          :recurso_id => @recurso.id,
          :user_id => (current_user.id rescue nil)
      )

      MailNotifier.delay.erro(@erro)

      redirect_to @erro
    end
end
