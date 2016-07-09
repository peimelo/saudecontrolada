class Api::V1::PasswordsController < ApplicationController
  skip_before_action :authenticate_with_token!

  def create
    User.send_reset_password_instructions(params[:email])

    render status: :ok, json: {
      message: I18n.t('passwords.create.message'),
      title: I18n.t('passwords.create.title')
    }
  end

  def update
    user = User.reset_password_by_token(params)

    if user.errors.empty?
      render status: :ok, json: {
        message: I18n.t('passwords.update.message'),
        title: I18n.t('passwords.update.title')
      }
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end
end
