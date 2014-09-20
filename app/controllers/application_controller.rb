class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # captura todos os erros, essa é a classe pai de todos os erros
  rescue_from StandardError, with: :erro if Rails.env == 'production'

  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :tem_permissao?, except: :erro

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(
          :current_password,
          :date_of_birth,
          :email,
          :gender,
          :name,
          :password,
          :password_confirmation
        )
      }

      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
          :date_of_birth,
          :email,
          :gender,
          :name,
          :password,
          :password_confirmation
        )
      }
    end

  private
    def erro(exception=nil)
      logger.warn '##########################################################'
      logger.warn '1##### Entrou no erro'
      get_recurso()
      logger.warn "2##### Recurso: #{@recurso.controlador.nome} / #{@recurso.acao.nome}" rescue 'recurso = erro'

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
      logger.warn "6##### ip: #{request.remote_ip}" rescue 'remote_id = erro'
      logger.warn "7##### user_id: #{current_user.id}" rescue 'user_id = erro'
      logger.warn "8##### user_email: #{current_user.email}" rescue 'user_email = erro'
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
          descricao: descricao_erro,
          dispositivo: request.user_agent.to_s,
          ip: request.remote_ip,
          nome: nome_erro,
          recurso_id: @recurso.id,
          user_id: (current_user.id rescue nil)
      )

      MailNotifier.delay.erro(@erro)

      redirect_to @erro
    end

    def get_recurso
      acao   = Acao.find_by_nome(action_name)
      acao ||= Acao.create(nome: action_name)

      controlador   = Controlador.find_by_nome(self.class.controller_path)
      controlador ||= Controlador.create(nome: self.class.controller_path)

      recurso_categoria   = RecursoCategoria.first
      recurso_categoria ||= RecursoCategoria.create(nome: t('banco_dados.registro.geral'))

      @recurso   = Recurso.find_by_acao_id_and_controlador_id(acao.id, controlador.id)
      @recurso ||= Recurso.create(acao_id: acao.id,
                                  controlador_id: controlador.id,
                                  nome: "#{ controlador.nome } / #{ acao.nome }",
                                  recurso_categoria_id: recurso_categoria.id)
    end
    
    def translate_version(version)
      case version
        when 'create'
          t('links.inclusao')
        when 'destroy'
          t('links.exclusao')
        when 'update'
          t('links.alteracao')
      end
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

    def tem_permissao?(param_action=action_name)
      #TODO: ajustar
      return true

      privileges = find_privileges

      if self.class.controller_path.to_s[0..5] == 'devise' ||
        privileges.item_existe?(param_action, self.class.controller_path) ||
        session[:administrador]
        true
      else
        erro()
        false
      end
    end

    def user_administrador_sistema?
      unless current_user.admin?
        erro()
        false
      end
    end
end
