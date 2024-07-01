class IndexController < ApplicationController
  def index
    @autor = Author.first
    @angels = Photo.joins(:category).where(categories: { name: 'Angels' })
    @lamps = Photo.joins(:category).where(categories: { name: 'Lamps' })
    @mandala = Photo.joins(:category).where(categories: { name: 'Mandala' })
    @misc = Photo.joins(:category).where(categories: { name: 'Misc' })
  end

  def gallery
  end
end
