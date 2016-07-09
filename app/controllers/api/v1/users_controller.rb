class Api::V1::UsersController < ApplicationController
  include Crud
  skip_before_action :authenticate_with_token!, only: [:create]
  before_action :admin?, only: [:index]

  def index
    users = User.ordered.page(params[:page])
    render json: users, meta: pagination_dict(users), adapter: :json,
           each_serializer: UsersSerializer, status: :ok
  end

  def show
    render json: current_user, status: :ok
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render status: :created, json: {
        message: I18n.t('users.create.message'),
        title: I18n.t('users.create.title')
      }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    user_updated = current_user.update_with_password(user_params)

    if user_updated
      render json: current_user, meta: I18n.t('flash.update'),
             adapter: :json, status: :ok
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.destroy

    if !current_user.persisted?
      render status: :ok, json: {
        message: I18n.t('users.destroy.message'),
        title: I18n.t('users.destroy.title')
      }
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :current_password,
      :date_of_birth,
      :email,
      :gender,
      :name,
      :password,
      :password_confirmation
    )
  end
end
