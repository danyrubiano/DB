class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include AASM

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :valorations, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  has_attached_file :foto_perfil, styles: {normal: "200x200", min:"100x100", ultra:"60x60"}
  validates_attachment_content_type :foto_perfil, content_type: /\Aimage\/.*\Z/
  
  scope :bloqueados, ->{ where(state:"bloqueado DESC")}
  scope :activos, ->{ where(state:"activo DESC")}


  include PermissionsConcerns

  def is_normal_user?
    self.permission_level == 1
  end

  def is_admin?
    self.permission_level == 2    
  end

  def is_gold_user?
    self.permission_level == 3
  end

  def update_to_gold_user
    self.save if self.permission_level.nil?
    self.update(permission_level: 3)
  end

  def update_to_normal_user
    self.save if self.permission_level.nil?
    self.update(permission_level: 1)
    self.update(post_diarios: 0)
  end

  def update_post_diarios
    self.save if self.post_diarios.nil?
    self.update(post_diarios: self.post_diarios + 1)
  end

  def reset_post_diarios
    self.update(post_diarios: 0)
  end

  aasm column: "state" do
    state :activo, initial: true
    state :bloqueado

    event :activar do
      transitions from: :bloqueado, to: :activo
    end

    event :bloquear do
      transitions from: :activo, to: :bloqueado
    end
  end

    # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

end
