class UsersController < ApplicationController
  before_action :user_administrador_sistema?

  def index
    @users = User.listar
    @users = @users.page(params[:page]) unless params[:format].present?

    respond_to do |format|
      format.html
      format.pdf do
        pdf = UsersPdf.new(@users, User)
        send_data pdf.render, filename: (User.model_name.human + '.pdf'), disposition: 'inline'
      end
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=#{ t('activerecord.models.user.other') }.xlsx"
      }
    end
  end
end
