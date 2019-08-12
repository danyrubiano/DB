class AddFotoPerfilToUsers < ActiveRecord::Migration
  def change
  	add_attachment :users, :foto_perfil
  end
end
