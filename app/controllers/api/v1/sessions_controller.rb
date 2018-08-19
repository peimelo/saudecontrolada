class Api::V1::SessionsController < ApplicationController
  skip_before_action :authenticate_with_token!, only: [:create]

  def create
    # user = User.authenticate(params)

    user = AuthenticateUser.new(params[:email], params[:password]).call
    # user = AuthenticateUser.call(params)

    if user.errors.empty?
      render json: user, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end
end
