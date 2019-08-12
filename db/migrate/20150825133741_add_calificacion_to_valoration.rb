class AddCalificacionToValoration < ActiveRecord::Migration
  def change
    add_column :valorations, :calificacion, :integer, default:0
  end
end
