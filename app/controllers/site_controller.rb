class SiteController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    if user_signed_in?
      session[:data_ultimo_resultado] = nil
      redirect_to dashboard_index_path
    end
  end
end
