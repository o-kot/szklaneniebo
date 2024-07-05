class ApplicationController < ActionController::Base
  helper_method :admin_logged_in?

  private

  def authenticate_admin!
    unless admin_logged_in?
      redirect_to admin_login_path, alert: 'Ta sekcja dostępna jest tylko dla administratora strony po zalogowaniu.'
    end
  end

  def admin_logged_in?
    session[:admin] == true
  end
end
