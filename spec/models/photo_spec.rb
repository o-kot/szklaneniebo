require 'rails_helper'

RSpec.describe Photo, type: :model do
  it { is_expected.to belong_to(:category) }
  it { is_expected.to have_one_attached(:image) }
end
