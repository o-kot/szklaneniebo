require 'rails_helper'

RSpec.feature "AdminDashboard", type: :feature do
  let(:category) { create(:category) }
  let(:author) { create(:author) }

  before do
    DatabaseCleaner.clean_with(:truncation)
    category
    author
    login_as_admin
  end

  scenario "redirects to login page if not authenticated" do
    visit admin_logout_path
    visit admin_dashboard_path
    expect(page).to have_current_path(admin_login_path)
  end

  scenario "updates author's photo" do
    visit admin_dashboard_path
    attach_file('author_photo', Rails.root.join('spec/fixtures/files/sample1.jpg'))
    click_link_or_button 'Zmień zdjęcie'
    expect(page).to have_content('Zdjęcie zostało zaktualizowane.')
  end

  scenario "updates author's about text" do
    visit admin_dashboard_path
    fill_in 'about-textarea', with: 'New about text'
    click_link_or_button 'Zmień tekst'
    expect(page).to have_content('Tekst został zaktualizowany.')
  end

  scenario "creates a new category and shows a success message" do
    visit admin_dashboard_path
    fill_in 'Nazwa kategorii', with: 'New Category'
    click_link_or_button 'Dodaj kategorię'
    expect(page).to have_content('Dodano nową kategorię do galerii')
  end

  scenario "creates a new category and verifies the category name" do
    visit admin_dashboard_path
    fill_in 'Nazwa kategorii', with: 'New Category'
    click_link_or_button 'Dodaj kategorię'
    expect(Category.last.name).to eq('New Category')
  end

  # Remove or add an expectation to the following scenario
  scenario "navigates to admin dashboard and selects a category" do
    visit admin_dashboard_path
    select category.name, from: 'photo_category_id'
    expect(page).to have_select('photo_category_id', selected: category.name) # Added expectation
  end

  scenario "uploads a photo to the selected category" do
    visit admin_dashboard_path
    select category.name, from: 'photo_category_id'
    attach_file('photo_images', Rails.root.join('spec/fixtures/files/sample.jpg'))
    click_link_or_button 'Dodaj witraż'
    expect(page).to have_content("Dodano nowy witraż do kategorii #{category.name}")
  end

  scenario "verifies the photo count in the category" do
    visit admin_dashboard_path
    select category.name, from: 'photo_category_id'
    attach_file('photo_images', Rails.root.join('spec/fixtures/files/sample.jpg'))
    click_link_or_button 'Dodaj witraż'
    expect(category.photos.count).to eq(1)
  end
end
