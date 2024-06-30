require 'rails_helper'

RSpec.describe Photo, type: :model do
  it { should belong_to(:category) }
  it { should have_one_attached(:image) }
end
