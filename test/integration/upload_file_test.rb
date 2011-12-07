require 'test_helper'
 
class UploadFileTest < ActionDispatch::IntegrationTest
  test "upload_pdf_file_success" do
	bulk_data = fixture_file_upload('files/Assue.Sonia@gmail.com.pdf', 'multipart/form')
	post "upload/file", {"datafile"=>bulk_data, "filetype"=>"pdf", "program"=>"phd"}, {"current_user"=>1,"abc"=>"cba","is_logged_in"=>"true","is_admin"=>"true"}
	assert File.exists?("public/data/pdf/phd/Assue.Sonia@gmail.com.pdf")
  end	
	
  test "upload_pdf_file_fail" do
	bulk_data = fixture_file_upload('files/non_exist_email.pdf', 'multipart/form')
	post "upload/file", {:datafile=>bulk_data, :filetype=>"pdf", :program=>"phd"}, {"current_user"=>"1","is_logged_in"=>"true","is_admin"=>"true"}
	assert !File.exists?("public/data/pdf/phd/non_exist_email.pdf")
  end


end
