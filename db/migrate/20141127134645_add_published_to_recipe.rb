class AddPublishedToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :published, :boolean
  end
end
