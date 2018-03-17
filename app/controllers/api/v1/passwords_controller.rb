class Api::V1::PasswordsController < ApplicationController
  include Crud
  skip_before_action :authenticate_with_token!

  def create
    user = User.send_reset_password_instructions(params[:email])
    render_user(user, 'passwords.create')
  end

  def update
    user = User.reset_password_by_token(params)
    render_user(user, 'passwords.update')
  end
end
