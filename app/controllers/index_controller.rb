class IndexController < ApplicationController
  def index
    @autor = Author.first
    @translated_about = translate_about(@autor.about)
    @categories = Category.includes(:photos).all
    @translated_category_names = translated_category_names
  end

  def gallery
  end

  private

  def translate_about(about_text)
    if I18n.locale == :en
      I18n.t('about.text')
    else
      about_text
    end
  end

  def translated_category_names
    I18n.t('categories.names')
  end
end
