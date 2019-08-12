class AddCalificacionToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :calificacion_total, :integer, default: 0
  end
end
