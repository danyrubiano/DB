class AddPostDiariosToUser < ActiveRecord::Migration
  def change
    add_column :users, :post_diarios, :integer, default:0
  end
end
