class ApplicationController < ActionController::Base
  helper_method :admin_logged_in?

  private

  def authenticate_admin!
    unless admin_logged_in?
      flash[:alert] = I18n.t('flash.admin_not_logged_alert', locale: :pl)
      redirect_to admin_login_path
    end
  end

  def admin_logged_in?
    session[:admin] == true
  end
end
