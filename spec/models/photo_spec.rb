require 'rails_helper'

RSpec.describe Photo, type: :model do
  let(:category) { create(:category, name: 'Category 1') }
  let(:another_category) { create(:category, name: 'Category 2') }
  let(:image_path) { Rails.root.join('spec/fixtures/files/sample.jpg') }
  let(:image_file) { fixture_file_upload(image_path, 'image/jpg') }

  it { is_expected.to belong_to(:category) }
  it { is_expected.to have_one_attached(:image) }

  context 'when validating uniqueness' do
    it 'is valid with a unique image in the category' do
      photo = category.photos.build(image: image_file)
      expect(photo).to be_valid
    end

    context 'with a duplicate image in the same category' do
      before do
        category.photos.create!(image: image_file)
      end

      it 'is not valid' do
        duplicate_photo = category.photos.build(image: image_file)
        expect(duplicate_photo).not_to be_valid
      end

      it 'adds an error message' do
        duplicate_photo = category.photos.build(image: image_file)
        duplicate_photo.validate
        expect(duplicate_photo.errors[:image]).to include('has already been added to this category')
      end
    end

    it 'is valid with a duplicate image in a different category' do
      category.photos.create!(image: image_file)
      new_photo_in_another_category = another_category.photos.build(image: image_file)
      expect(new_photo_in_another_category).to be_valid
    end
  end
end
