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
end
