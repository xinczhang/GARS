module ReviewHelper
def review_list reviews
	html = "<div id='displayAppsArea'>"
	reviews.each do |r| 
        	#app = r.application 
        	#html +=  'ID: ' + app.id.to_s() 
        	#html += 'Rating: ' + r.rating.to_s() + 'Review: ' + r.review
		if r.submitted == 1
			html += submitted_review r
		else
			html += unsubmitted_review r
		end
	end
	html += "</div>"
	html.html_safe
end



def submitted_review r
	ay = r.application.apply_yourself
	html = <<DIV
		<div class="appWrapper">
                <div class="appControls">
                        <div style="width: 15px; height:15px; background-color:green; margin-top: 2px; margin-left: 2px;margin-right: 5px; display:inline-block"></div>
			<a href="#" class="expandAppBtn">Expand</a>
                </div>
                <div class="appArea">
                                     	<div class="appHeader">
                                                <div class="appHeaderTitle">
                                                        <a href="/applications/#{r.application.id}"  class="appName">#{ay.first_name} #{ay.last_name}</a>
                                                </div>
						<span>Rating = #{r.rating}</span>,
                                                <span class="appSchool">#{ay.citizenship}</span>,
                                                <span class="appMajor">#{ay.ug_inst}</span>,
                                                <span class="appGPA">#{ay.ug_GPA} out of #{ay.ug_scale}</span>
					</div>
					<div class="appContent">
						#{r.review}
					</div>
		</div>
		</div>
DIV
	html
end

def unsubmitted_review r
	ay = r.application.apply_yourself
	html =<<DIV 
		<div class="appWrapper">
                	<div class="appControls">
                		<div style="width: 15px; height:15px; background-color:red; margin-top: 2px; margin-left: 2px;margin-right: 5px; display:inline-block"></div>
				<a href="#" class="editCommentBtn">Expand</a>
			</div>
			
				<div class="appArea">
					<div class="appHeader">
                                                <div class="appHeaderTitle">
                                                        <a href="/applications/#{r.application.id}"  class="appName">#{ay.first_name} #{ay.last_name}</a>
                                                </div>             
                                                <span class="appSchool">#{ay.citizenship}</span>,
                                                <span class="appMajor">#{ay.ug_inst}</span>,
                                                <span class="appGPA">#{ay.ug_GPA} out of #{ay.ug_scale}</span>
                                        </div> 


                                        <div class="appContent">
DIV

	inside_table =<<DIV
			<table>
					 <tr>

                                <td width="111">
					<input type='hidden' name='id' = value='#{r.id}'/>
					Select rating:
				</td>
                                <td width="459">
                                    #{rating_selector r.rating,1,10}
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">Enter Comment:</td>
                            </tr>
                            <tr>
                                <td colspan="2"><textarea name='review' cols="90" rows="7">#{r.review}</textarea></td>
                            </tr>
                          
                            <tr>
                                <td colspan="2">
					<input type="submit" name='submit' value="Save"  class="jqBtn"/>
                	                <input type="submit" name='submit'  value="Submit" class="jqBtn commentSubmitBtn"/>
				
				</td>
                            </tr>
                        </table>
DIV
	html << form_tag('/reviews/post_review', :method => :post) do 
				inside_table.html_safe 
			end
	html << "</div></div></div>"
	html.html_safe
end

def rating_selector rating,min,max
   html = "<select name='rating'"

   (min..max).to_a.each do |r|
     if r == rating
       html += "<option selected='selected' value='#{r}'>#{r}</option>"
     else
       html += "<option value='#{r}'>#{r}</option>"
     end
   end
   html += "</select>"
   html
end
end
