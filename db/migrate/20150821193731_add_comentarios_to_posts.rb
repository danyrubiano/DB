class AddComentariosToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :total_comments, :integer, default: 0
  end
end
