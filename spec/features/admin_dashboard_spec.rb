require 'rails_helper'

RSpec.feature "AdminDashboard", type: :feature do
  before do
    DatabaseCleaner.clean_with(:truncation)
    @author = create(:author)
    @category = create(:category)
    allow_any_instance_of(ApplicationController).to receive(:authenticate_admin!).and_return(true)
  end

  scenario "redirects to login page if not authenticated" do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_admin!).and_call_original
    visit admin_dashboard_path
    expect(page).to have_current_path(admin_login_path)
  end

  scenario "updates author's photo" do
    visit admin_dashboard_path
    attach_file('author_photo', Rails.root.join('spec/fixtures/files/sample1.jpg'))
    click_button 'Zmień zdjęcie'
    expect(page).to have_content('Zdjęcie zostało zaktualizowane.')
  end

  scenario "updates author's about text" do
    visit admin_dashboard_path
    fill_in 'about-textarea', with: 'New about text'
    click_button 'Zmień tekst'
    expect(page).to have_content('Tekst o sobie został zaktualizowany.')
  end

  scenario "creates a new category" do
    visit admin_dashboard_path
    fill_in 'Nazwa kategorii', with: 'New Category'
    click_button 'Dodaj kategorię'
    expect(page).to have_content('Dodano nową kategorię do galerii')
    expect(Category.last.name).to eq('New Category')
  end

  scenario "adds photos to a category" do
    visit admin_dashboard_path
    select @category.name, from: 'photo_category_id'
    attach_file('photo_images', Rails.root.join('spec/fixtures/files/sample.jpg'))
    click_button 'Dodaj witraż'
    expect(page).to have_content("Dodano nowy witraż do kategorii #{@category.name}")
    expect(@category.photos.count).to eq(1)
  end
end
