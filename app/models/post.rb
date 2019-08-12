class Post < ActiveRecord::Base
  
  include AASM
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :valorations, dependent: :destroy

  validates :titulo, length: {maximum: 50}
  validates :descripcion, length: {maximum: 2000}
  validates :cover, presence: true

  before_save :set_visits_count
  before_create :set_total_comments, :set_num_calificaciones #, :send_mail


  has_attached_file :cover, styles: { max: "560x400", mini:"200x150", medium: "800x600", thumb:"600x400", minini:"100x75"}
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

  scope :ultimos, ->{ order("created_at DESC")}
  scope :mas_visitados, ->{ order("visits_count DESC")}
  scope :mejor_valorados, ->{ order("(calificacion_total / num_calificaciones) DESC")}

  def update_visits_count
  	self.save if self.visits_count.nil?
  	self.update(visits_count: self.visits_count + 1)
  end

  def update_total_comments
    self.save if self.total_comments.nil?
    self.update(total_comments: self.total_comments + 1)
  end

  def del_comments
    self.update(total_comments: self.total_comments - 1)
    
  end

  def add_calificacion(increment)
    self.increment!(:calificacion_total, increment)
  end

  def update_num_calificaciones
    self.save if self.num_calificaciones.nil?
    self.update(num_calificaciones: self.num_calificaciones + 1)
  end


  private

  #def send_mail
    #AdminMailer.new_post(self).delivery_later
  #end


  def set_visits_count
  	self.visits_count ||= 0
  end

  def set_total_comments
    self.total_comments ||= 0
  end

  def set_num_calificaciones
    self.num_calificaciones ||= 0
  end

end
