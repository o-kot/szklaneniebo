# spec/factories/authors.rb
FactoryBot.define do
  factory :author do
    name { "Alicja Zapolska" }
    about { "Fascynacja witrażami była we mnie od zawsze." }
    after(:build) do |author|
      author.photo.attach(io: Rails.root.join('spec/fixtures/files/sample.jpg').open, filename: 'sample.jpg', content_type: 'image/jpg')
    end
  end
end
