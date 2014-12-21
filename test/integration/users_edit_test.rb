require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: "",
                                    email: "foo@invalidid",
                                    password: "foo",
                                    password_confirmation: "bar" }
    assert_template "users/edit"                                    
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = "foo bar"
    email = "foo@bar.com"
    patch user_path(@user), user: {name: name, email: email,
                                   password: "foobar",
                                   password_confirmation: "foobar"
    }
    assert_redirected_to user_path(@user)
    follow_redirect!
    assert_template "users/show"
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
  end
end
