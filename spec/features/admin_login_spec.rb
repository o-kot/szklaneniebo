require 'rails_helper'

RSpec.feature "AdminLogin", type: :feature do
  scenario "renders login form" do
    visit '/admin/login'
    expect(page).to have_content('Login')
    expect(page).to have_content('Hasło')
  end

  scenario "displays error with invalid credentials" do
    visit '/admin/login'
    fill_in 'Hasło', with: 'wrongpassword'
    click_button 'Zaloguj'
    expect(page).to have_content('Nieprawdidłowe hasło albo login')
  end
end
