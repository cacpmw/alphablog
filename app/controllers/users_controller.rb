class UsersController < ApplicationController
  before_action :set_user, except: %i[new index create]
  before_action :required_user, only: %i[update destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Alpha Blog #{@user.username}"
      redirect_to users_path(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'User was succesfully updated'
      render 'show'
    else
      render 'edit'
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @user.destroy
    flash[:danger] = "User and all its articles have been deleted"
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:warning] = 'User not found'
    redirect_to articles_path
  end

  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:warning] = 'You can only manage you own profile'
      redirect_to root_path
    end
  end

  def require_admin
    if logged_in? and (!current_user.admin? and current_user != @user)
      flash[:warning] = 'Only admins are allowed to perform that action'
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
