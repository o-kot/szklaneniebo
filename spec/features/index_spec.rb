require 'rails_helper'

RSpec.feature "IndexPage", type: :feature do
  before do
    create(:author, about: "Fascynacja witrażami była we mnie od zawsze.")
    I18n.backend.store_translations(:en, { about: { text: "I've always been fascinated by stained glass." } })
  end

  scenario "renders index page with expected content in default locale" do
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

  scenario "loads the artist's photo" do
    visit root_path
    expect(page).to have_css("img[alt='Artist portrait']")
  end

  scenario "renders index page with expected content in English locale" do
    visit root_path(locale: :en)
    expect(page).to have_content("I've always been fascinated by stained glass.")
  end
end
