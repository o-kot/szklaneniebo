require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { create(:category) }

  it { is_expected.to have_many(:photos) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
end
