require 'rails_helper'

RSpec.describe Author, type: :model do
  it "is valid with valid attributes" do
    author = build(:author)
    expect(author).to be_valid
  end

  it "can have a photo attached" do
    author = create(:author)
    expect(author.photo).to be_attached
  end

  it "is not valid without an about text" do
    author = build(:author, about: nil)
    expect(author).not_to be_valid
  end
end
