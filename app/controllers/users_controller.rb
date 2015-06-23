class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction

  before_action :user_administrador_sistema?

  def index
    @users = User.listar(params[:search], params[:format], params[:page], sort_column + ' ' + sort_direction)

    respond_to do |format|
      format.html
      format.pdf do
        pdf = UsersPdf.new(@users, User)
        send_data pdf.render, filename: (User.model_name.human + '.pdf'), disposition: 'inline'
      end
      format.xls
    end
  end

  private

    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : 'current_sign_in_at'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end
end
