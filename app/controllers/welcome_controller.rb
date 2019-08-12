class WelcomeController < ApplicationController

  before_action :authenticate_admin!, only:[:auditoria]
  before_action :authenticate_user!, only:[:compraGold, :serGold, :serNormal]
  before_action :user_activo!,only:[:compraGold, :serGold, :serNormal]

  def index
  end

  def usuarios
  	@users = User.all
  end

  def auditoria
  	@posts = Post.paginate(page: params[:page],per_page:5).ultimos
  	@comments = Comment.paginate(page: params[:page],per_page:20).last_comments
  	@valorations = Valoration.paginate(page: params[:page],per_page:10)
  end

  def compraGold
    if user_signed_in? && current_user.is_gold_user?
      redirect_to root_url
      flash.notice = "Ya eres Gold User"
    end
  end

  def serGold
    if user_signed_in? && current_user.is_gold_user?
      redirect_to root_url
      flash.notice = "Ya eres Gold User"
    elsif user_signed_in? && current_user.is_normal_user?
      current_user.update_to_gold_user
      redirect_to root_url
      flash.notice = "Has ascendido a Gold User"
    end
  end

  def serNormal
    if user_signed_in? && current_user.is_normal_user?
      redirect_to root_url
      flash.notice = "Ya eres Normal User"
    elsif user_signed_in? && current_user.is_gold_user?
      current_user.update_to_normal_user
      redirect_to root_url
      flash.notice = "Has descendido a Normal User"
    end
  end

end
