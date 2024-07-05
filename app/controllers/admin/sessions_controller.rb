class Admin::SessionsController < ApplicationController
  def new
  end

  def create
    if params[:username] == 'admin' && params[:password] == ENV['ADMIN_PASSWORD']
      session[:admin] = true
      redirect_to admin_dashboard_path
    else
      flash[:alert] = 'Nieprawdidłowe hasło albo login'
      render :new
    end
  end

  def destroy
    session[:admin] = nil
    redirect_to admin_login_path, notice: 'Zostałeś wylogowany'
  end
end
