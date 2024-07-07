require 'rails_helper'

RSpec.feature "AdminSession", type: :feature do
  let(:admin_password) { 'correctpassword' }

  before do
    allow(ENV).to receive(:[]).with('ADMIN_PASSWORD').and_return(admin_password)
  end

  scenario "renders login form with login text" do
    visit '/admin/login'
    expect(page).to have_content('Login')
  end

  scenario "renders login form with password text" do
    visit '/admin/login'
    expect(page).to have_content('Hasło')
  end

  scenario "displays error with invalid credentials" do
    visit '/admin/login'
    fill_in 'Hasło', with: 'wrongpassword'
    click_link_or_button 'Zaloguj'
    expect(page).to have_content('Nieprawdidłowe hasło albo login')
  end

  scenario "logs in with valid credentials" do
    visit '/admin/login'
    fill_in 'Hasło', with: admin_password
    click_link_or_button 'Zaloguj'
    expect(page).to have_current_path(admin_dashboard_path(locale: :pl))
  end

  scenario "displays the admin dashboard after login" do
    login_as_admin
    expect(page).to have_current_path(admin_dashboard_path(locale: :pl))
  end

  scenario "displays the admin dashboard content" do
    login_as_admin
    expect(page).to have_content('Panel administracyjny')
  end

  scenario "logs out the admin" do
    login_as_admin
    click_link_or_button 'Wyloguj'
    expect(page).to have_current_path(admin_login_path(locale: :pl))
  end

  scenario "displays logout message" do
    login_as_admin
    click_link_or_button 'Wyloguj'
    expect(page).to have_content('Zostałeś wylogowany')
  end

  scenario "redirects to login page if not authenticated" do
    visit admin_dashboard_path
    expect(page).to have_current_path(admin_login_path(locale: :pl))
  end

  scenario "displays unauthorized access message if not authenticated" do
    visit admin_dashboard_path
    expect(page).to have_content('Ta sekcja dostępna jest tylko dla administratora strony po zalogowaniu.')
  end

  def login_as_admin
    visit admin_login_path
    fill_in 'username', with: 'admin'
    fill_in 'password', with: admin_password
    click_link_or_button 'Zaloguj'
  end
end
