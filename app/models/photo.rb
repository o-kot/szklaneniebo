class Photo < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  validate :unique_photo_in_category

  private

  def unique_photo_in_category
    return unless image.attached?

    existing_photo = category.photos.joins(image_attachment: :blob).where(active_storage_blobs: { checksum: image.blob.checksum }).first

    return unless existing_photo

    errors.add(:image, 'has already been added to this category')
  end
end
