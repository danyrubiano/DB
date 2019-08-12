class AddNumCalifiacionesToPost < ActiveRecord::Migration
  def change
    add_column :posts, :num_calificaciones, :integer, default:0
  end
end
