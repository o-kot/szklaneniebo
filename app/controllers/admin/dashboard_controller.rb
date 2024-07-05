class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_autor, only: [:index, :update_author_photo, :update_author_about]

  def index
    @categories = Category.all
  end

  def update_author_photo
    if params[:author].present? && params[:author][:photo].present?
      if @autor.update(photo: author_params[:photo])
        flash[:author_photo_notice] = 'Zdjęcie zostało zaktualizowane.'
      else
        flash[:author_photo_alert] = 'Wystąpił błąd podczas aktualizacji zdjęcia.'
      end
    else
      flash[:author_photo_alert] = 'Wybierz zdjęcie do aktualizacji.'
    end
    redirect_to admin_dashboard_path
  end

  def update_author_about
    if @autor.update(about: author_params[:about])
      flash[:author_about_notice] = 'Tekst o sobie został zaktualizowany.'
    else
      flash[:author_about_alert] = 'Nie udało się zaktualizować tekstu o sobie.'
    end
    redirect_to admin_dashboard_path
  end

  def create_category
    @category = Category.new(category_params)
    if @category.save
      flash[:category_notice] = 'Dodano nową kategorię do galerii'
    else
      flash[:category_alert] = 'Błąd przy dodawaniu kategorii'
    end
    redirect_to admin_dashboard_path
  end

  def add_photos
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      if params[:images].present? && params[:images].any? { |image| image.present? }
        params[:images].compact_blank.each do |image|
          @category.photos.create(image: image)
        end
        flash[:photo_notice] = "Dodano nowy witraż do kategorii #{@category.name}"
      else
        flash[:photo_alert] = 'Wybierz zdjęcia do dodania'
      end
    else
      flash[:photo_alert] = 'Wybierz kategorię'
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
end
