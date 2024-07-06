require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do
  before do
    @category = create(:category)
    @autor = create(:author)
    allow(Author).to receive(:first).and_return(@autor) # Ensure the set_autor method returns the correct @autor
    session[:admin] = true
  end

  describe 'PATCH #update_author_photo' do
    context 'when author and photo params are present and update is successful' do
      before do
        allow(@autor).to receive(:update).and_return(true)
        patch :update_author_photo, params: { author: { photo: fixture_file_upload('sample.jpg', 'image/jpg') } }
      end

      it 'sets a flash notice' do
        expect(flash[:author_photo_notice]).to eq(I18n.t('flash.author_photo_notice', locale: :pl))
      end

      it 'redirects to the admin dashboard path' do
        expect(response).to redirect_to(admin_dashboard_path)
      end
    end

    context 'when author and photo params are present but update fails' do
      before do
        allow(@autor).to receive(:update).and_return(false)
        patch :update_author_photo, params: { author: { photo: fixture_file_upload('sample2.jpg', 'image/jpg') } }
      end

      it 'sets a flash alert for update error' do
        expect(flash[:author_photo_alert]).to eq(I18n.t('flash.author_photo_update_error', locale: :pl))
      end

      it 'redirects to the admin dashboard path' do
        expect(response).to redirect_to(admin_dashboard_path)
      end
    end

    context 'when author or photo params are missing' do
      before do
        patch :update_author_photo, params: { author: { photo: nil } }
      end

      it 'sets a flash alert for missing photo' do
        expect(flash[:author_photo_alert]).to eq(I18n.t('flash.author_photo_alert', locale: :pl))
      end

      it 'redirects to the admin dashboard path' do
        expect(response).to redirect_to(admin_dashboard_path)
      end
    end
  end

  describe 'POST #add_photos' do
    context 'when category_id is missing' do
      before do
        post :add_photos, params: { images: [fixture_file_upload('sample.jpg', 'image/jpg')] }
      end

      it 'sets a flash alert for missing category_id' do
        expect(flash[:photo_alert]).to eq(I18n.t('flash.new_art_category_missing_error', locale: :pl))
      end

      it 'redirects to the admin dashboard path' do
        expect(response).to redirect_to(admin_dashboard_path)
      end
    end

    context 'when images are missing' do
      before do
        post :add_photos, params: { category_id: @category.id, images: [] }
      end

      it 'sets a flash alert for missing images' do
        expect(flash[:photo_alert]).to eq(I18n.t('flash.new_art_missing_error', locale: :pl))
      end

      it 'redirects to the admin dashboard path' do
        expect(response).to redirect_to(admin_dashboard_path)
      end
    end
  end

  describe 'PATCH #update_author_about' do
    context 'when about params are present and update is successful' do
      before do
        allow(@autor).to receive(:update).and_return(true)
        patch :update_author_about, params: { author: { about: 'New about info' } }
      end

      it 'sets a flash notice' do
        expect(flash[:author_about_notice]).to eq(I18n.t('flash.author_about_notice', locale: :pl))
      end

      it 'redirects to the admin dashboard path' do
        expect(response).to redirect_to(admin_dashboard_path)
      end
    end

    context 'when about params are present but update fails' do
      before do
        allow(@autor).to receive(:update).and_return(false)
        patch :update_author_about, params: { author: { about: 'New about info' } }
      end

      it 'sets a flash alert for update error' do
        expect(flash[:author_about_alert]).to eq(I18n.t('flash.author_about_update_error', locale: :pl))
      end

      it 'redirects to the admin dashboard path' do
        expect(response).to redirect_to(admin_dashboard_path)
      end
    end
  end
end
