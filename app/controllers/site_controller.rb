class SiteController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    if user_signed_in?
      if Peso.count > 0
        redirect_to dashboard_index_path
      else
        redirect_to pesos_path
      end
    end
  end
end
