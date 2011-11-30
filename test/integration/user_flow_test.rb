require 'test_helper'
 
class UserFlowsTest < ActionDispatch::IntegrationTest
  fixtures :all
 
  test "successful login as chair controller test" do
  	# make a login request to the controller
	post "home/login"
	# post the test user email and password	
	post_via_redirect "home/login", :email => users(:person1).email, :password => users(:person1).password
	#judge if we return the error message in the cache
	assert_nil(flash[:error], users(:person1).email + " login fail with correct password: " + users(:person1).password)
	#judge if we return a user object successfully
	assert_not_nil(session[:current_user], "fail to return a user object!")
	assert_equal(session[:current_user].role, 0, "User not login as chair!")
	
	end

  test "fail login controller test" do
        # make a login request to the controller
        post "home/login"
        # post the test user email and password 
        post_via_redirect "home/login", :email => users(:person1).email, :password => users(:person2).password
        #judge if we return the error message in the cache
	assert_equal("username and password are incorrect", flash[:error], users(:person1).email + " login succeed with wrong password: " + users(:person2).password)
        end
 
end
