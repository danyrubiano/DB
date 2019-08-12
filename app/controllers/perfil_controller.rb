class PerfilController < ApplicationController

	before_action :authenticate_admin!, only:[:bloquear, :activar]
	before_action :authenticate_user!, only:[:following, :followers]

	def show 
	  @users = User.find(params[:id])
  	  if @users.is_admin?
		redirect_to root_url 
	  end 	
	end

	def bloquear
	  @user = User.find(params[:id])
	  @user.bloquear!
	  redirect_to perfil_path
	  flash.notice = "Usuario bloqueado correctamente"
	end 

	def activar
	  @user = User.find(params[:id])
	  @user.activar!
	  redirect_to perfil_path
	  flash.notice = "Usuario activado correctamente"
	end 

	def following
      @title = "Following"
      @user  = User.find(params[:id])
      @users = @user.following.paginate(page: params[:page],per_page:8)
      render 'show_follow'
    end

    def followers
      @title = "Followers"
      @user  = User.find(params[:id])
      @users = @user.followers.paginate(page: params[:page],per_page:8)
      render 'show_follow'
    end
end
