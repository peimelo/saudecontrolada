class Api::V1::ConfirmationsController < ApplicationController
  skip_before_action :authenticate_with_token!

  def create
    User.send_confirmation_instructions(params[:email])

    render status: :ok, json: {
      message: I18n.t('confirmations.create.message'),
      title: I18n.t('confirmations.create.title')
    }
  end

  def update
    user = User.confirm_by_token(params[:token])

    if user.errors.empty?
      render status: :ok, json: {
        message: I18n.t('confirmations.edit.message'),
        title: I18n.t('confirmations.edit.title')
      }
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end
end
