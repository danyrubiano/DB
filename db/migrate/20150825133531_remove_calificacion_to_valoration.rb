class RemoveCalificacionToValoration < ActiveRecord::Migration
  def change
    remove_column :valorations, :calificacion, :integer
  end
end
