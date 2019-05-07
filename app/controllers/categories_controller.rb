class CategoriesController < ApplicationController
  before_action :set_category, except: %i[index new create]

  def index
    @categories = Category.paginate(page: params[:page], per_page:5)
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Category was successfully created'
      redirect_to category_path(@category)
    else
      render 'new'
    end
  end

  def new
    @category = Category.new
  end

  def edit

  end

  def update
    if @category.update(category_params)
      flash[:success] = 'Category was successfully updated'
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end

  def show

  end

  private

  def set_category
    @category = Category.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:warning] = 'Category not found'
    redirect_to categories_path
  end

  def category_params
    params.require(:category).permit(:name)
  end
end