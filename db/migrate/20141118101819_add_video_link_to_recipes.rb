class AddVideoLinkToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :video_link, :string
  end
end
