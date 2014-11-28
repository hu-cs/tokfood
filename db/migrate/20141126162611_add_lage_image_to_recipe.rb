class AddLageImageToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :large_image, :string
  end
end
