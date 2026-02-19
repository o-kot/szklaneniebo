namespace :photos do
  desc "Resize all existing photos to max dimensions (2000x2000) with backup"
  task resize_all: :environment do
    require 'fileutils'
    require 'image_processing/vips'

    # Create backup directory with timestamp
    backup_dir = Rails.root.join('storage', 'photo_backups', Time.now.strftime('%Y%m%d_%H%M%S'))
    FileUtils.mkdir_p(backup_dir)

    puts "📸 Starting photo resize operation..."
    puts "📁 Backup directory: #{backup_dir}"
    puts ""

    photos = Photo.includes(:image_attachment).where.not(image_attachment: { id: nil })
    total_photos = photos.count

    if total_photos.zero?
      puts "✅ No photos found to resize."
      return
    end

    puts "Found #{total_photos} photo(s) to process"
    puts "=" * 60

    processed = 0
    resized = 0
    skipped = 0
    errors = 0

    photos.find_each.with_index do |photo, index|
      begin
        next unless photo.image.attached?

        # Get image dimensions
        image_blob = photo.image.blob
        metadata = image_blob.metadata

        # Skip if already small enough
        if metadata['width'] && metadata['height'] &&
           metadata['width'] <= Photo::MAX_IMAGE_DIMENSION &&
           metadata['height'] <= Photo::MAX_IMAGE_DIMENSION
          puts "[#{index + 1}/#{total_photos}] ⏭️  Skipping Photo ##{photo.id} (#{image_blob.filename}) - already optimized (#{metadata['width']}x#{metadata['height']})"
          skipped += 1
          next
        end

        puts "[#{index + 1}/#{total_photos}] 🔄 Processing Photo ##{photo.id} (#{image_blob.filename})..."

        # Backup original image
        backup_file = backup_dir.join("photo_#{photo.id}_#{image_blob.filename}")
        File.open(backup_file, 'wb') do |file|
          file.write(image_blob.download)
        end
        puts "   ✓ Backed up to: #{backup_file.relative_path_from(Rails.root)}"

        # Download and resize
        original_filename = image_blob.filename.to_s
        original_content_type = image_blob.content_type

        begin
          # Try Vips first
          resized_image = ImageProcessing::Vips
            .source(image_blob.download)
            .resize_to_limit(Photo::MAX_IMAGE_DIMENSION, Photo::MAX_IMAGE_DIMENSION)
            .saver(quality: Photo::IMAGE_QUALITY)
            .call

          # Replace the image
          photo.image.purge
          photo.image.attach(
            io: File.open(resized_image.path),
            filename: original_filename,
            content_type: original_content_type
          )

          resized_image.unlink if resized_image.respond_to?(:unlink)

          puts "   ✓ Resized successfully"
          resized += 1

        rescue LoadError
          # Fallback to ImageMagick
          puts "   ℹ️  Falling back to ImageMagick..."

          resized_image = ImageProcessing::MiniMagick
            .source(image_blob.download)
            .resize_to_limit(Photo::MAX_IMAGE_DIMENSION, Photo::MAX_IMAGE_DIMENSION)
            .convert('jpg')
            .saver(quality: Photo::IMAGE_QUALITY)
            .call

          photo.image.purge
          photo.image.attach(
            io: File.open(resized_image.path),
            filename: original_filename,
            content_type: original_content_type
          )

          resized_image.unlink if resized_image.respond_to?(:unlink)

          puts "   ✓ Resized successfully (ImageMagick)"
          resized += 1
        end

        processed += 1

      rescue => e
        puts "   ❌ Error processing Photo ##{photo.id}: #{e.message}"
        puts "      Original image preserved in backup"
        errors += 1
      end
    end

    puts ""
    puts "=" * 60
    puts "✅ Resize operation complete!"
    puts ""
    puts "📊 Summary:"
    puts "   Total photos: #{total_photos}"
    puts "   Resized: #{resized}"
    puts "   Skipped (already optimized): #{skipped}"
    puts "   Errors: #{errors}"
    puts ""
    puts "📁 Backups saved to: #{backup_dir.relative_path_from(Rails.root)}"
    puts ""

    if errors > 0
      puts "⚠️  Some photos had errors. Check the logs above."
      puts "   Original images are preserved in the backup directory."
    end
  end

  desc "Restore photos from a backup directory"
  task :restore_from_backup, [:backup_path] => :environment do |t, args|
    unless args[:backup_path]
      puts "❌ Error: Please provide a backup directory path"
      puts "Usage: rails photos:restore_from_backup[storage/photo_backups/TIMESTAMP]"
      exit 1
    end

    backup_dir = Rails.root.join(args[:backup_path])

    unless File.directory?(backup_dir)
      puts "❌ Error: Backup directory not found: #{backup_dir}"
      exit 1
    end

    puts "🔄 Restoring photos from backup: #{backup_dir}"
    puts ""

    restored = 0
    errors = 0

    Dir.glob(backup_dir.join("photo_*")).each do |backup_file|
      begin
        # Extract photo ID from filename (photo_123_filename.jpg)
        filename = File.basename(backup_file)
        photo_id = filename.match(/photo_(\d+)_/)[1].to_i

        photo = Photo.find(photo_id)

        # Restore the backup
        photo.image.purge if photo.image.attached?
        photo.image.attach(
          io: File.open(backup_file),
          filename: filename.sub(/^photo_\d+_/, ''),
          content_type: Marcel::MimeType.for(Pathname.new(backup_file))
        )

        puts "✓ Restored Photo ##{photo_id}"
        restored += 1

      rescue => e
        puts "❌ Error restoring #{File.basename(backup_file)}: #{e.message}"
        errors += 1
      end
    end

    puts ""
    puts "=" * 60
    puts "✅ Restore complete!"
    puts "   Restored: #{restored}"
    puts "   Errors: #{errors}"
  end
end
