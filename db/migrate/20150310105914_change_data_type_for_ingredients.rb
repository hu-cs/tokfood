class ChangeDataTypeForIngredients < ActiveRecord::Migration
  def change
    change_table(:recipes) do |t|
     t.change :ingredients, :text
    end
  end
end
