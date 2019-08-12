class Valoration < ActiveRecord::Base
  
  include AASM

  belongs_to :user
  belongs_to :post
  validates :user_id, uniqueness: { scope: :post_id, message: "Ya valoraste esta foto"}
  validates_inclusion_of :calificacion, :in => 1..5 , message: "La valoración debe ir entre 1 y 5"


end
