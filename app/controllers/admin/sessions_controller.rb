class Admin::SessionsController < ApplicationController
  def new
  end

  def create
    if params[:username] == 'admin' && params[:password] == ENV['ADMIN_PASSWORD']
      session[:admin] = true
      redirect_to admin_dashboard_path
    else
      flash[:alert] = I18n.t('flash.admin_login_error', locale: :pl)
      render :new
    end
  end

  def destroy
    session[:admin] = nil
    flash[:notice] = I18n.t('flash.admin_logout_notice', locale: :pl)
    redirect_to admin_login_path
  end
end
