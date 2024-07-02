class AddAboutToAuthors < ActiveRecord::Migration[7.1]
  def change
    add_column :authors, :about, :text
  end
end
