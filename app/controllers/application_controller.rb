class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  # include ActionController::RequestForgeryProtection
  # include Authenticable

  # protect_from_forgery with: :null_session, if: Proc.new {
  #   |c| c.request.format == 'application/vnd.saudecontrolada.v1'
  # }

  # before_action :authenticate_with_token!
end
