class ApplicationController < ActionController::Base
  helper_method :admin_logged_in?
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def authenticate_admin!
    unless admin_logged_in?
      flash[:alert] = I18n.t('flash.admin_not_logged_alert')
      redirect_to admin_login_path
    end
  end

  def admin_logged_in?
    session[:admin] == true
  end
end
