class ArticlesController < ApplicationController
  before_action :set_article, except: %i[new index create]

  def new
    @article = Article.new
  end

  def index
    @articles = Article.all
  end

  def create

    @article = Article.new(articles_params)
    @article.user = User.first
    if @article.save
      flash[:success] = 'Article was successfully created'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @article.update(articles_params)
      flash[:success] = 'Article was successfully updated'
      redirect_to article_path(@article)
    else
      render 'edit'
    end

  end

  def show; end

  def destroy
    @article.destroy
    flash[:danger] = 'Article was successfully destroyed'
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def articles_params
    params.require(:article).permit(:title, :description)
  end
end
