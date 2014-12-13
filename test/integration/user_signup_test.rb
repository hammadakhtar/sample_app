require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  test ""  do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, user: {name: "", email: "wrong@example", 
                             password: "foo", password_confirmation: "bar" }
    end
    
    assert_template "users/new"
  end
end
