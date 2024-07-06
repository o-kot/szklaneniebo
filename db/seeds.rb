require 'fileutils'

Author.destroy_all
Photo.destroy_all
Category.destroy_all

Author.create(
  id: 1,
  name: 'Alicja Zapolska',
  about: "Fascynacja witrażami była we mnie od zawsze.\nObraz, który się zmienia. Gra światła do słonecznej muzyki.\nKiedyś byłam przekonana, że witraże to hobby dla nielicznych.\nI tak jest - wymaga cierpliwości, pokory, akceptacji, niespieszności.\nSzkło - kruche i twarde, zimne i ciepłe, delikatne i ostre...\nZauroczyło mnie i wypełniło wolne chwile.\nWitrażowe hobby trwa już kilka lat, pracuję w technice Tiffaniego.\nMoje prace goszczą w wielu domach, zarówno w Polsce jak i za granicą.\nKONTAKT - alicja-631@wp.pl\nDziękuję za odwiedzenie mej strony..."
)

Author.first.photo.attach(
  io: Rails.root.join('spec/fixtures/files/alice.jpg').open,
  filename: 'alice.jpg',
  content_type: 'image/jpg'
)

Rails.logger.debug "Authors seeded successfully"

Category.create([
                  {
                    id: 1,
                    name: "Anioły"
                  },
                  {
                    id: 2,
                    name: "Lampy"
                  },
                  {
                    id: 3,
                    name: "Mandale"
                  },
                  {
                    id: 4,
                    name: "Różne"
                  }
                ])

Rails.logger.debug "Categories seeded successfully"

Photo.create([
               {
                 id: 1,
                 category_id: 1,
                 image: Rails.root.join('spec/fixtures/art_works/P1070452.JPG').open
               },
               {
                 id: 2,
                 category_id: 1,
                 image: Rails.root.join('spec/fixtures/art_works/P1080099.JPG').open
               },
               {
                 id: 3,
                 category_id: 1,
                 image: Rails.root.join('spec/fixtures/art_works/P1080584.JPG').open
               },
               {
                 id: 4,
                 category_id: 2,
                 image: Rails.root.join('spec/fixtures/art_works/IMG_20170429_175415.jpg').open
               },
               {
                 id: 5,
                 category_id: 2,
                 image: Rails.root.join('spec/fixtures/art_works/IMG_20171015_200059.jpg').open
               },
               {
                 id: 6,
                 category_id: 2,
                 image: Rails.root.join('spec/fixtures/art_works/IMG_20181201_154349.jpg').open
               },
               {
                 id: 7,
                 category_id: 2,
                 image: Rails.root.join('spec/fixtures/art_works/P1050842.JPG').open
               },
               {
                 id: 8,
                 category_id: 3,
                 image: Rails.root.join('spec/fixtures/art_works/IMG_20210228_123517.jpg').open
               },
               {
                 id: 9,
                 category_id: 3,
                 image: Rails.root.join('spec/fixtures/art_works/P1090554.JPG').open
               },
               {
                 id: 10,
                 category_id: 3,
                 image: Rails.root.join('spec/fixtures/art_works/P1100569.JPG').open
               },
               {
                 id: 11,
                 category_id: 4,
                 image: Rails.root.join('spec/fixtures/art_works/IMG_20200101_183426.jpg').open
               },
               {
                 id: 12,
                 category_id: 4,
                 image: Rails.root.join('spec/fixtures/art_works/IMG_20210304_173324.jpg').open
               },
               {
                 id: 13,
                 category_id: 4,
                 image: Rails.root.join('spec/fixtures/art_works/P1070673.JPG').open
               }
             ])

Rails.logger.debug "Photos seeded successfully"