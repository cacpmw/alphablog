require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @article = Article.new(title: 'Article Title', description: 'Article Description', user_id: 3)
  end

  test 'article should be valid' do
    assert @article.valid?
  end

end
