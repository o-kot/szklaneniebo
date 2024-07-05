require 'rails_helper'

RSpec.describe Admin::SessionsController, type: :controller do
  describe "POST #create" do
    context "with valid credentials" do
      before do
        allow(ENV).to receive(:[]).with('ADMIN_PASSWORD').and_return('correctpassword')
        post :create, params: { username: 'admin', password: 'correctpassword' }
      end

      it "sets the session for admin" do
        expect(session[:admin]).to be_truthy
      end

      it "redirects to the dashboard" do
        expect(response).to redirect_to(admin_dashboard_path)
      end
    end

    context "with invalid credentials" do
      before do
        allow(ENV).to receive(:[]).with('ADMIN_PASSWORD').and_return('correctpassword')
        post :create, params: { username: 'admin', password: 'wrongpassword' }
      end

      it "does not set session" do
        expect(session[:admin]).to be_nil
      end

      it "renders new template" do
        expect(response).to render_template(:new)
      end

      it "sets flash alert" do
        expect(flash[:alert]).to eq('Nieprawdidłowe hasło albo login')
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      session[:admin] = true
      delete :destroy
    end

    it "logs out the admin" do
      expect(session[:admin]).to be_nil
    end

    it "redirects to login page" do
      expect(response).to redirect_to(admin_login_path)
    end

    it "sets flash notice" do
      expect(flash[:notice]).to eq('Zostałeś wylogowany')
    end
  end
end
