class RelationshipsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :user_activo!

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    redirect_to 'perfil/#{@user.id}'
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    redirect_to 'perfil/#{@user.id}'
  end
end
