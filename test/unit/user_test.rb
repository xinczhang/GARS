require 'test_helper'

class UserTest < ActiveSupport::TestCase
   test "create a new empty user" do
	u = User.new;
	assert_raise(ActiveRecord::StatementInvalid){u.save};
	
  end

   test "fetch existing user by email and password" do
	#use dummy data from yaml
	email = users(:person1).email 
	psswd = users(:person1).password
	#find in database
	@user = User.find(:first, :conditions=>["email=? AND password=?", email, psswd])
	assert_not_nil(@user, "Fail to fetch the existing user!")
  	 
    end

    test "delete a user" do
	id = users(:person1).id
	User.delete(id)
        assert_raise(ActiveRecord::RecordNotFound){ Application.find(id) }
    end

    test "Grant user privilege" do
	user = users(:person1)
	user.role = 0
	user.save
	assert_equal(User.find(user.id).role, 0, "user privilege not granted!")
    end

end
