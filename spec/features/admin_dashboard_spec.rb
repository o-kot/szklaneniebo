require 'rails_helper'

RSpec.feature "AdminDashboard", type: :feature do
  let(:category) { create(:category) }
  let(:author) { create(:author) }
  let(:image_path) { Rails.root.join('spec/fixtures/files/sample.jpg') }

  before do
    DatabaseCleaner.clean_with(:truncation)
    category
    author
    login_as_admin
  end

  def upload_photo_to_category(category_name, image_path)
    visit admin_dashboard_path
    select category_name, from: 'photo_category_id'
    attach_file('photo_images', image_path)
    click_link_or_button 'Dodaj witraż'
  end

  def add_category(name)
    visit admin_dashboard_path
    fill_in 'Nazwa kategorii', with: name
    click_link_or_button 'Dodaj kategorię'
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
    add_category('New Category')
    expect(page).to have_content('Dodano nową kategorię do galerii')
  end

  scenario "creates a new category and verifies the category name" do
    add_category('New Category')
    expect(Category.last.name).to eq('New Category')
  end

  scenario "navigates to admin dashboard and selects a category" do
    visit admin_dashboard_path
    select category.name, from: 'photo_category_id'
    expect(page).to have_select('photo_category_id', selected: category.name)
  end

  scenario "uploads a photo to the selected category" do
    upload_photo_to_category(category.name, image_path)
    expect(page).to have_content("Dodano nowy witraż do kategorii #{category.name}")
  end

  scenario "verifies the photo count in the category" do
    upload_photo_to_category(category.name, image_path)
    expect(category.photos.count).to eq(1)
  end

  context 'when handling duplicate entries' do
    scenario "shows an error when uploading a duplicate photo" do
      upload_photo_to_category(category.name, image_path)
      upload_photo_to_category(category.name, image_path)
      expect(page).to have_content('Ten witraż już istnieje w tej kategorii.')
    end

    scenario "ensures the photo count does not increase when uploading a duplicate photo" do
      upload_photo_to_category(category.name, image_path)
      upload_photo_to_category(category.name, image_path)
      expect(category.photos.count).to eq(1)
    end

    scenario "shows an error when adding a duplicate category name" do
      add_category(category.name)
      expect(page).to have_content('Wystąpił błąd podczas dodawaniu kategorii.')
    end
  end
end
