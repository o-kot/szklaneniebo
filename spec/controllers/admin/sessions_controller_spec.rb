require 'rails_helper'

RSpec.describe Admin::SessionsController, type: :controller do
  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid credentials" do
      it "sets session and redirects to dashboard" do
        allow(ENV).to receive(:[]).with('ADMIN_PASSWORD').and_return('correct_password')
        post :create, params: { username: 'admin', password: 'correct_password' }
        expect(session[:admin]).to be_truthy
        expect(response).to redirect_to(admin_dashboard_path)
      end
    end

    context "with invalid credentials" do
      it "does not set session and renders new with alert" do
        allow(ENV).to receive(:[]).with('ADMIN_PASSWORD').and_return('correct_password')
        post :create, params: { username: 'admin', password: 'wrong_password' }
        expect(session[:admin]).to be_falsey
        expect(response).to render_template(:new)
        expect(flash[:alert]).to eq('Nieprawdidłowe hasło albo login')
      end
    end
  end
end
