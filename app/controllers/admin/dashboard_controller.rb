class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_autor, only: [:index, :update_author_photo, :update_author_about]

  def index
    @categories = Category.all
  end

  def update_author_photo
    if params[:author].present? && params[:author][:photo].present?
      if @autor.update(photo: author_params[:photo])
        flash[:author_photo_notice] = I18n.t('flash.author_photo_notice')
      else
        flash[:author_photo_alert] = I18n.t('flash.author_photo_update_error')
      end
    else
      flash[:author_photo_alert] = I18n.t('flash.author_photo_alert')
    end
    redirect_to admin_dashboard_path
  end

  def update_author_about
    if @autor.update(about: author_params[:about])
      flash[:author_about_notice] = I18n.t('flash.author_about_notice')
    else
      flash[:author_about_alert] = I18n.t('flash.author_about_update_error')
    end
    redirect_to admin_dashboard_path
  end

  def create_category
    @category = Category.new(category_params)
    if @category.save
      flash[:category_notice] = I18n.t('flash.new_category_notice')
    else
      flash[:category_alert] = I18n.t('flash.new_category_error')
    end
    redirect_to admin_dashboard_path
  end

  def add_photos
    if params[:category_id].present?
      add_photos_to_category(params[:category_id], params[:images])
    else
      flash_alert(I18n.t('flash.new_art_category_missing_error'))
    end
    redirect_to admin_dashboard_path
  end

  private

  def set_autor
    @autor = Author.first
  end

  def author_params
    params.require(:author).permit(:photo, :about)
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def add_photos_to_category(category_id, images)
    @category = Category.find(category_id)

    if images.present? && images.any? { |image| image.present? }
      if save_photos(images)
        flash_notice(I18n.t('flash.new_art_notice', category_name: @category.name))
      else
        flash_alert(I18n.t('flash.new_art_duplicate_error'))
      end
    else
      flash_alert(I18n.t('flash.new_art_missing_error'))
    end
  end

  def save_photos(images)
    success = true
    images.compact_blank.each do |image|
      photo = @category.photos.create(image: image)
      unless photo.persisted?
        success = false
        break
      end
    end
    success
  end

  def flash_notice(message, now: false)
    now ? flash.now[:photo_notice] = message : flash[:photo_notice] = message
  end

  def flash_alert(message, now: false)
    now ? flash.now[:photo_alert] = message : flash[:photo_alert] = message
  end
end
