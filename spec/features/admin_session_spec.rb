require 'rails_helper'

RSpec.feature "AdminSession", type: :feature do
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

  scenario "logs in with valid credentials" do
    allow(ENV).to receive(:[]).with('ADMIN_PASSWORD').and_return('correctpassword')
    visit '/admin/login'
    fill_in 'Hasło', with: 'correctpassword'
    click_button 'Zaloguj'
    expect(page).to have_current_path(admin_dashboard_path)
  end

  scenario "admin logs in and then logs out" do
    visit admin_login_path
    fill_in 'username', with: 'admin'
    fill_in 'password', with: ENV['ADMIN_PASSWORD']
    click_button 'Zaloguj'
    expect(page).to have_current_path(admin_dashboard_path)
    expect(page).to have_content('Panel administracyjny')
    click_link 'Wyloguj'
    expect(page).to have_current_path(admin_login_path)
    expect(page).to have_content('Zostałeś wylogowany')
  end

  scenario "redirects to login page if not authenticated" do
    visit admin_dashboard_path
    expect(page).to have_current_path(admin_login_path)
    expect(page).to have_content('Ta sekcja dostępna jest tylko dla administratora strony po zalogowaniu.')
  end
end
