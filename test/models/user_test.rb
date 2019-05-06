require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: 'Username', email: 'email@gmail.com', password: 'secret')
  end

  test 'user should be valid' do
    assert @user.valid?
  end

  test 'username should be unique' do
    @user.save
    user2 = User.new(username: 'Username', email: 'user2@gmail.com', password: 'secret')
    assert_not user2.valid?
  end
  test 'username should be present' do
    user = User.new(email: 'user2@gmail.com', password: 'secret')
    assert_not user.valid?
  end

  test 'username should not be too long' do
    user = User.new(username: 'Username' * 25, email: 'user2@gmail.com', password: 'secret')
    assert_not user.valid?
  end
  test 'username should not be too short' do
    user = User.new(username: 'Uu', email: 'user2@gmail.com', password: 'secret')
    assert_not user.valid?
  end
  test 'email should be present' do
    user = User.new(username: 'Username', password: 'secret')
    assert_not user.valid?
  end

  test 'email should be unique' do
    @user.save
    user2 = User.new(username: 'Username', email: 'email@gmail.com', password: 'secret')
    assert_not user2.valid?
  end

  test 'email should not be too long' do
    user = User.new(username: 'Username', email: ('email' * 100) + '@gmail.com', password: 'secret')
    assert_not user.valid?
  end
  test 'email should not be too short' do
    user = User.new(username: 'Username', email:'e@g.com', password: 'secret')
    assert_not user.valid?
  end
end
