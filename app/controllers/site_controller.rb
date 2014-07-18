class SiteController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    redirect_to dashboard_index_path if user_signed_in?
  end
end
