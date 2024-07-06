require 'fileutils'

def attach_photo(photo, file_path)
  photo.image.attach(
    io: Rails.root.join(file_path).open,
    filename: File.basename(file_path),
    content_type: 'image/jpg'
  )
  photo.save!
end

def seed_authors
  Author.destroy_all

  author = Author.create!(
    id: 1,
    name: 'Alicja Zapolska',
    about: "Fascynacja witrażami była we mnie od zawsze.\n" \
           "Obraz, który się zmienia. Gra światła do słonecznej muzyki.\n" \
           "Kiedyś byłam przekonana, że witraże to hobby dla nielicznych.\n" \
           "I tak jest - wymaga cierpliwości, pokory, akceptacji, niespieszności.\n" \
           "Szkło - kruche i twarde, zimne i ciepłe, delikatne i ostre...\n" \
           "Zauroczyło mnie i wypełniło wolne chwile.\n" \
           "Witrażowe hobby trwa już kilka lat, pracuję w technice Tiffaniego.\n" \
           "Moje prace goszczą w wielu domach, zarówno w Polsce jak i za granicą.\n" \
           "KONTAKT - alicja-631@wp.pl\n" \
           "Dziękuję za odwiedzenie mej strony..."
  )

  author.photo.attach(
    io: Rails.root.join('spec/fixtures/files/alice.jpg').open,
    filename: 'alice.jpg',
    content_type: 'image/jpg'
  )

  Rails.logger.debug "Authors seeded successfully"
end

def seed_categories
  Category.destroy_all

  Category.create!([
                     { id: 1, name: "Anioły" },
                     { id: 2, name: "Lampy" },
                     { id: 3, name: "Mandale" },
                     { id: 4, name: "Różne" }
                   ])

  Rails.logger.debug "Categories seeded successfully"
end

def seed_photos
  Photo.destroy_all

  photo_data = [
    { id: 1, category_id: 1, path: 'spec/fixtures/art_works/P1070452.JPG' },
    { id: 2, category_id: 1, path: 'spec/fixtures/art_works/P1080099.JPG' },
    { id: 3, category_id: 1, path: 'spec/fixtures/art_works/P1080584.JPG' },
    { id: 4, category_id: 2, path: 'spec/fixtures/art_works/IMG_20170429_175415.jpg' },
    { id: 5, category_id: 2, path: 'spec/fixtures/art_works/IMG_20171015_200059.jpg' },
    { id: 6, category_id: 2, path: 'spec/fixtures/art_works/IMG_20181201_154349.jpg' },
    { id: 7, category_id: 2, path: 'spec/fixtures/art_works/P1050842.JPG' },
    { id: 8, category_id: 3, path: 'spec/fixtures/art_works/IMG_20210228_123517.jpg' },
    { id: 9, category_id: 3, path: 'spec/fixtures/art_works/P1090554.JPG' },
    { id: 10, category_id: 3, path: 'spec/fixtures/art_works/P1100569.JPG' },
    { id: 11, category_id: 4, path: 'spec/fixtures/art_works/IMG_20200101_183426.jpg' },
    { id: 12, category_id: 4, path: 'spec/fixtures/art_works/IMG_20210304_173324.jpg' },
    { id: 13, category_id: 4, path: 'spec/fixtures/art_works/P1070673.JPG' }
  ]

  photo_data.each do |photo|
    p = Photo.new(id: photo[:id], category_id: photo[:category_id])
    attach_photo(p, photo[:path])
  end

  Rails.logger.debug "Photos seeded successfully"
end

ActiveRecord::Base.transaction do
  seed_authors
  seed_categories
  seed_photos
end

Rails.logger.debug "Database seeded successfully"
