class CreateValorations < ActiveRecord::Migration
  def change
    create_table :valorations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true
      t.integer :calificacion

      t.timestamps null: false
    end
  end
end
