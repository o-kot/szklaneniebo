require 'rails_helper'

module DatabaseSeedsTest
  RSpec.describe 'Database Seeds' do
    before do
      @max_retries = 5
      @retry_interval = 0.1
      with_retry(@max_retries, @retry_interval) do
        Rails.application.load_seed
      end
    end

    after do
      DatabaseCleaner.clean
    end

    def with_retry(max_retries, retry_interval)
      retries = 0
      begin
        yield
      rescue ActiveRecord::StatementInvalid => e
        raise e unless e.cause.is_a?(SQLite3::BusyException) && retries < max_retries

        retries += 1
        sleep(retry_interval)
        retry
      end
    end

    it 'creates the author with the correct about information' do
      author = Author.find_by(name: 'Alicja Zapolska')
      expect(author&.about).to include('Fascynacja witrażami była we mnie od zawsze.')
    end

    it 'creates the expected categories' do
      categories = ['Anioły', 'Lampy', 'Mandale', 'Różne']
      categories.each do |category_name|
        category = Category.find_by(name: category_name)
        expect(category).not_to be_nil
      end
    end

    it 'creates the expected photo' do
      photo = Photo.find_by(id: 1)
      expect(photo).not_to be_nil
    end

    it 'associates the photo with the correct category' do
      photo = Photo.find_by(id: 4)
      expect(photo&.category&.name).to eq('Lampy')
    end

    it 'attaches the photo to the author' do
      author = Author.find_by(name: 'Alicja Zapolska')
      expect(author&.photo).to be_attached
    end
  end
end
