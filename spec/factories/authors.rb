FactoryBot.define do
  factory :author do
    name { "Alicja Zapolska" }

    after(:create) do |author|
      file = Tempfile.new(['alice', '.png'])
      file.binmode
      file.write("fake image content")
      file.rewind

      author.photo.attach(io: file, filename: 'alice.png', content_type: 'image/png')
    end
  end
end
