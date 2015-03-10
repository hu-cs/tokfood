class ChangeDataTypeForServing < ActiveRecord::Migration
  def change
    change_table(:recipes) do |t|
     t.change :serving, :text
    end
  end
end
