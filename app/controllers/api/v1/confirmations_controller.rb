class Api::V1::ConfirmationsController < ApplicationController
  include Crud
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
    render_user(user, 'confirmations.edit')
  end
end
