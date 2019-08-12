class AddNameUToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_name, :string
    add_column :users, :fecha_nacimiento, :date
  end
end
