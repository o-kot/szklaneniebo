class Photo < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  validate :unique_photo_in_category
  after_commit :resize_image, on: [:create, :update]

  MAX_IMAGE_DIMENSION = 2000
  IMAGE_QUALITY = 85

  private

  def unique_photo_in_category
    return unless image.attached?

    existing_photo = category.photos.joins(image_attachment: :blob).where(active_storage_blobs: { checksum: image.blob.checksum }).first

    return unless existing_photo

    errors.add(:image, 'has already been added to this category')
  end

  def resize_image
    return unless image.attached?
    return unless image.blob.content_type.start_with?('image/')

    require 'image_processing/vips'

    begin
      resized_image = ImageProcessing::Vips
        .source(image.blob.download)
        .resize_to_limit(MAX_IMAGE_DIMENSION, MAX_IMAGE_DIMENSION)
        .saver(quality: IMAGE_QUALITY)
        .call

      image.attach(
        io: File.open(resized_image.path),
        filename: image.blob.filename,
        content_type: image.blob.content_type
      )
    rescue LoadError
      # Fall back to ImageMagick if Vips is not available
      resized_image = ImageProcessing::MiniMagick
        .source(image.blob.download)
        .resize_to_limit(MAX_IMAGE_DIMENSION, MAX_IMAGE_DIMENSION)
        .convert('jpg')
        .saver(quality: IMAGE_QUALITY)
        .call

      image.attach(
        io: File.open(resized_image.path),
        filename: image.blob.filename,
        content_type: image.blob.content_type
      )
    ensure
      resized_image&.unlink if resized_image.respond_to?(:unlink)
    end
  end
end
