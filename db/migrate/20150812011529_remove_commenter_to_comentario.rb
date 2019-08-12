class RemoveCommenterToComentario < ActiveRecord::Migration
  def change
    remove_column :comentarios, :commenter, :string
  end
end
