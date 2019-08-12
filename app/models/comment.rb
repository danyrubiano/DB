class Comment < ActiveRecord::Base
  
  include AASM
  
  belongs_to :user
  belongs_to :post
  validates :body, presence: true, length: {maximum: 1000}
  validates :anonimo, presence: true
  #validates :tipo_usuario, presence: true

  scope :last_comments, ->{ order("created_at DESC")}
end

