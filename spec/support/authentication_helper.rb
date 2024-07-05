module AuthenticationHelper
  def login_as_admin
    visit admin_login_path
    fill_in 'username', with: 'admin'
    fill_in 'password', with: ENV.fetch('ADMIN_PASSWORD', nil)
    click_link_or_button 'Zaloguj'
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelper, type: :feature
end
