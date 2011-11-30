require 'test_helper'

class SearchFlowsTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "search all the applications have the name" do
        # make a login request to the controller
        post "home/login"
        # post the test user email and password 
        post_via_redirect "home/login", :email => users(:person1).email, :password => users(:person1).password
        #judge if we return the error message in the cache
        assert_nil(flash[:error], users(:person1).email + " login fail with correct password: " + users(:person1).password)

	post_via_redirect "home/search", :searchQuery => 'Alan'
	
	end

end
