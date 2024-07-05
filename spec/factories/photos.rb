FactoryBot.define do
  factory :photo do
    category
    after(:build) do |photo|
      photo.image.attach(io: Rails.root.join('spec/fixtures/files/sample.jpg').open, filename: 'sample.jpg', content_type: 'image/jpg')
    end
  end
end
