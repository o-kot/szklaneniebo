class IndexController < ApplicationController
  def index
    @autor = Author.first
    @categories = Category.includes(:photos).all
  end

  def gallery
  end
end
