require 'rails_helper'

RSpec.describe Admin::SessionsController, type: :controller do
  describe "POST #create" do
    context "with valid credentials" do
      before do
        allow(ENV).to receive(:[]).with('ADMIN_PASSWORD').and_return('correctpassword')
        post :create, params: { username: 'admin', password: 'correctpassword' }
      end

      it "sets session and redirects to dashboard" do
        expect(session[:admin]).to be_truthy
        expect(response).to redirect_to(admin_dashboard_path)
      end
    end

    context "with invalid credentials" do
      before do
        allow(ENV).to receive(:[]).with('ADMIN_PASSWORD').and_return('correctpassword')
        post :create, params: { username: 'admin', password: 'wrongpassword' }
      end

      it "does not set session and renders new" do
        expect(session[:admin]).to be_nil
        expect(response).to render_template(:new)
        expect(flash[:alert]).to eq('Nieprawdidłowe hasło albo login')
      end
    end

    it "logs out the admin and redirects to login page with notice" do
      session[:admin] = true
      delete :destroy
      expect(session[:admin]).to be_nil
      expect(response).to redirect_to(admin_login_path)
      expect(flash[:notice]).to eq('Zostałeś wylogowany')
    end
  end
end
