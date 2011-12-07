module UploadHelper
def upload_div_helper
	content_tag(:div, :id => "upload-form",  :title => "Uploading File" ) do
		form_tag('/upload/file', :multipart => true) do
			content_tag(:p) do
				"Please specify your program:".html_safe +
				content_tag(:br) +
				select_tag("applicationtype", "<option value=\"phd\">PhD</option><option value=\"master\">Master</option>".html_safe) +
				content_tag(:br) +
				"Please specify a file, or a set of files:".html_safe +
				content_tag(:br) +
				select_tag("filetype", "<option value=\"ay-mapping\">Apply Yourself Mapping</option><option value=\"ots-mapping\">Official Test Score Mapping</option><option value=\"ay\">Apply Yourself</option><option value=\"ots\">Official Test Score</option><option value=\"zip\">zip file</option><option value=\"pdf\">pdf file</option>".html_safe) +
				content_tag(:br) +
				file_field_tag("datafile", :size=>"40")	
			end +
				content_tag(:div) do
					submit_tag("Upload",:id=>"upload-btn")
				end
		end + '<br/><br/><h2 id="uploadErrorMsgListTitle">Upload History Log</h2><ul id="uploadErrorMsgList"></ul>'.html_safe
	end
end

end
