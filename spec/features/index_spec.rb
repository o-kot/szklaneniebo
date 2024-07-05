require 'rails_helper'

RSpec.feature "IndexPage", type: :feature do
  before(:all) do
    create(:author)
  end

  scenario "renders index page with expected content" do
    visit root_path
    expect(page).to have_content('Fascynacja witrażami była we mnie od zawsze.')
  end

  scenario "displays the artist's name at the bottom" do
    visit root_path
    expect(page).to have_content('Alicja Zapolska')
  end

  scenario "loads the logo image" do
    visit root_path
    expect(page).to have_css("img[src*='logo']")
  end

  before(:each) do
    @autor = create(:author)
  end

  scenario "loads the artist's photo" do
    visit root_path
    expect(page).to have_css("img[alt='Artist portrait']")
  end
end
