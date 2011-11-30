require 'test_helper'
 
class UploadFileTest < ActionDispatch::IntegrationTest
  test "successful upload_pdf file" do
	bulk_data = fixture_file_upload('files/Computer+Networks4e+Solution+Manual.pdf','multipart/form')
	post_via_redirect "home/file", :datafile=>bulk_data, :filetype=>"pdf"
  
	assert File.exists?("public/data/pdf/Computer+Networks4e+Solution+Manual.pdf"), "File is not upload"
  end

  test "validate_OTS_mapping_file_fail" do
	bulk_data = fixture_file_upload('files/OTS-map-bad.txt', 'multipart/form')
	post_via_redirect "home/file", :datafile=>bulk_data, :filetype=>"ots-mapping"
	assert_equal false, flash[:upload_status]
  end	

end
