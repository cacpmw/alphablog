class UsersController < ApplicationController
  before_action :set_user, except: %i[new index create]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Alpha Blog #{@user.username}"
      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit;
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

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:warning] = 'User not found'
    redirect_to articles_path
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
