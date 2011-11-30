require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase
  test "insert an empty application" do
     application = Application.new
     assert !application.save, "Your shouldn't insert an empty applicatoin"
  end

  test "insert an application with ay" do
	application = Application.new
	application.apply_yourself = ApplyYourself.new(:applicantClientID=>3,:applicantLastName=>'jim',:applicantFirstName=>'hu',:applicantMiddleName=>'T.',:gender=>1)
	assert application.save, "You should include at least one AY or OTS data"
  end

  test "insert an application been applied before" do
	application = Application.new(:id=>1,:apply_yourself_id=>10,:official_test_score_id=>10)	
	assert !application.save, "Application should fail if one already existed"
  end

  test "get an application by applicant name" do
	application = Application.joins(:apply_yourself).where("apply_yourselves.applicantFirstName=? AND apply_yourselves.applicantLastName=?","Alan","Perlis")
	assert !application.nil?, "Application has not found"
  end

  test "delete an application" do
	Application.delete(1)
	assert_raise(ActiveRecord::RecordNotFound){ Application.find(1) }
  end

end
