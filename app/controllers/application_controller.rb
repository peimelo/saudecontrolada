class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from StandardError, with: :server_error if Rails.env != 'development'

  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(
        :current_password,
        :date_of_birth,
        :email,
        :gender,
        :name,
        :password,
        :password_confirmation)
      }

      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
        :date_of_birth,
        :email,
        :gender,
        :name,
        :password,
        :password_confirmation)
      }
    end

    def server_error(exception)
      logger.warn "##### ERRO = #{exception}"

      ExceptionNotifier.ignored_exceptions = []

      ExceptionNotifier.notify_exception(
          exception,
          env: request.env,
          data: { current_user: current_user }
      )

      render file: "#{Rails.root}/public/erro.html", layout: false
    end

  private

    def user_administrador_sistema?
      unless current_user.admin?
        redirect_to root_path, alert: t('mensagens.erros.sem_permissao')
      end
    end
end
