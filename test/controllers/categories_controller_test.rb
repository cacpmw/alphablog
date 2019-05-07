require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "New Category")
  end

  test 'should get categories index' do
    get categories_path
    assert_response :success
  end

  test 'should get new' do
    get new_category_path
    assert_response :success
  end

  test 'should get show' do
    get category_path(@category)
    assert_response :success
  end

  test 'should get edit' do
    get edit_category_path(@category)
    assert_response :success
  end

#   test 'should update category' do
#     patch category_path(@category), params: { article: { description: nil, title: 'Updated Title' } }
#     assert_redirected_to category_path(@category)
#   end

end