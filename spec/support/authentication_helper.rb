module AuthenticateHelper
  def login_admin
    allow_any_instance_of(Admin::DashboardController).to receive(:authenticate_admin!).and_return(true)
  end

  def logout_admin
    allow_any_instance_of(Admin::DashboardController).to receive(:authenticate_admin!).and_call_original
  end
end

RSpec.configure do |config|
  config.include AuthenticateHelper, type: :feature
end
