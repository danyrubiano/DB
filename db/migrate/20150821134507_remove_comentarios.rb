class RemoveComentarios < ActiveRecord::Migration
  def change
  	drop_table :comentarios
  	#remove_column :posts, :texto, :text
  	#remove_column :

  	#t.text     "texto",      limit: 65535
    #t.integer  "post_id",    limit: 4
    #t.datetime "created_at",               null: false
    #t.datetime "updated_at",               null: false
    #t.integer  "user_id",    limit: 4
  end
end
