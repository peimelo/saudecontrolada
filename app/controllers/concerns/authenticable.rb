module Authenticable
  private

  def authenticate_with_token!
    render json: { errors: I18n.t('failure.unauthenticated') },
           status: :unauthorized unless user_signed_in?
  end

  def current_user
    @current_user ||= User.find_by(
      authentication_token: request.headers['Authorization']
    ) if request.headers['Authorization'].present?
  end

  def user_signed_in?
    current_user.present? && current_user.confirmed?
  end

  def admin?
    render json: { errors: I18n.t('failure.unauthorized') },
           status: :forbidden unless current_user.admin?
  end
end
