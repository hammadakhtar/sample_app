require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  test "test for invalid user"  do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, user: {name: "", email: "wrong@example", 
                             password: "foo", password_confirmation: "bar" }
    end
    
    assert_template "users/new"
  end
  
  test "test for valid user" do
    get signup_path
    assert_difference "User.count", 1 do
      post_via_redirect users_path, user: {name:  "Example User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password"}
    end
    
    assert_template "users/show"
  end
end
