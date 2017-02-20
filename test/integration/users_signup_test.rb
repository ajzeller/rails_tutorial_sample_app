require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do # verifies correct behavior upon invalid form submission
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "", email: "user@invalid",
        password: "foo", password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    assert_select 'form[action="/signup"]'
  end

  test 'valid signp information' do #confirm that a user was created
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "Example User",
                                         email: "user@example.com",
                                         password: "password",
                                         password_confirmation: "password"}}

    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end