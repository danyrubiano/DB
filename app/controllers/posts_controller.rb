class PostsController < ApplicationController

  before_action :authenticate_user!, except:[:show, :inicio]
  before_action :user_activo!, except: [:show, :inicio, :index]
  before_action :validar_post_diarios, only: [:create, :new]
  before_action :set_post, except:[:index, :new, :create, :inicio]

  def new
    @post = Post.new
  end

  def inicio
    @posts = Post.paginate(page: params[:page],per_page:8).mejor_valorados.ultimos
    if user_signed_in?
      @user  = current_user
      @users = @user.following
      @posts_f = Post.paginate(page: params[:page],per_page:8).ultimos
    end
  end

  def create
    @post = current_user.posts.new(post_params)
    
    if @post.save
      redirect_to @post
      @post.user.update_post_diarios
    else
      render 'new'
    end
  end
  
  def show
    if not @post.user == current_user
      @post.update_visits_count
    end
    @comment = Comment.new
    @valoration = Valoration.new
  end

  def index
    if current_user.is_admin?
      @posts = Post.paginate(page: params[:page],per_page:6).mejor_valorados.ultimos
    else
      @posts = current_user.posts.paginate(page: params[:page],per_page:6).ultimos
    end
  end

  def edit
  end
  
  def update
 
    if @post.update(params[:post].permit(post_params))
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy

    if current_user.is_normal_user?
      redirect_to posts_path
    elsif current_user.is_admin?
      redirect_to root_path
    end
  end


private
  def set_post
    @post = Post.find(params[:id])
  end 
  def post_params
    params.require(:post).permit(:titulo, :descripcion, :cover)
  end


end
