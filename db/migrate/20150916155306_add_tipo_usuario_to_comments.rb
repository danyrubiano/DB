class AddTipoUsuarioToComments < ActiveRecord::Migration
  def change
    add_column :comments, :tipo_usuario, :integer
  end
end
