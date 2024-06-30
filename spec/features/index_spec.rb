require 'rails_helper'

RSpec.feature "IndexPage", type: :feature do
  scenario "renders index page with expected content" do
    visit root_path
    expect(page).to have_content('Fascynacja witrażami była we mnie od zawsze.')
    expect(page).to have_selector('.gallery-categories')
  end

  scenario "displays the artist's name at the bottom" do
    visit root_path
    expect(page).to have_content('Alicja Zapolska')
  end

  scenario "loads the logo image" do
    visit root_path
    expect(page).to have_css("img[src*='logo']")
  end

  scenario "loads the main photo" do
    visit root_path
    expect(page).to have_css("img[src*='alice']")
  end
end
