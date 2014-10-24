class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :creator
      t.string :url
      t.string :ingredients
      t.string :serving
      t.string :notes

      t.timestamps
    end
  end
end
