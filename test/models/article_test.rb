require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "test_user", email: 'test@email.com', password: '123456')
    @user.save
    @article = Article.new(title: 'Article Title', description: 'Article Description', user: @user)
  end

  test 'article should be valid' do
    assert @article.valid?
  end

  test 'title should be present' do
    @article.title = ''
    assert_not @article.valid?
  end
  test 'title should not be too long' do
    @article.title = 'Title' * 50
    assert_not @article.valid?
  end
  test 'article should not be too short' do
    @article.title = 'a'
    assert_not @article.valid?
  end

  test 'description should not be too long' do
    @article.description = 'description' * 300
    assert_not @article.valid?
  end
  test 'description should not be too short' do
    @article.description = 'a'
    assert_not @article.valid?
  end
  test 'description should be present' do
    @article.description = ''
    assert_not @article.valid?
  end
  test 'user_id should be present' do
    @article.user = nil
    assert_not @article.valid?
  end

end
