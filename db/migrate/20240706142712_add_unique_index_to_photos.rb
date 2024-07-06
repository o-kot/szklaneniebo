class AddUniqueIndexToPhotos < ActiveRecord::Migration[6.0]
  def change
    add_index :active_storage_attachments, [:record_id, :record_type, :blob_id], unique: true, name: 'index_unique_photos_on_category_and_image'
  end
end
