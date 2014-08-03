class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  skip_before_action :tem_permissao?
  before_action :user_administrador_sistema?

  def index
    if params[:format] # xls mostra tudo
      @users = User.order(:created_at)
    else
      @users = User.search(params[:search]).order(sort_column + ' ' + sort_direction).page(params[:page])
    end

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
    def set_user
      @user = User.find(params[:id])
    end
    
    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : 'current_sign_in_at'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end
end
