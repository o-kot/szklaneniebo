FactoryBot.define do
  factory :photo do
    association :category
    after(:build) do |photo|
      photo.image.attach(io: File.open(Rails.root.join('spec/fixtures/files/sample.jpg')), filename: 'sample.jpg', content_type: 'image/jpg')
    end
  end
end
