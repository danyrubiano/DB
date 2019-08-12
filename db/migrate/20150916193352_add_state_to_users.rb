class AddStateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :state, :string, default: "activo"
  end
end
