module AssignReviewHelper
def assign_reviews_dialog_helper
	html =<<HTML
		<div id="assignReviewsDialog" title="Assign Reviewers" class='section nocollapsing'>
HTML
	inside_div=<<DIV
			<div class="header">
				<div style='float:left'>				
					#{country_selector 'country'}
					#{research_area_selector 'research-area'}
				</div>
				#{will_paginate @reviewers, :page_links => false, :previous_label=>'Prev', :next_label=>'Next', :param_name => :review_page}
			</div>
			<div class='content' style='padding:0px'>
				#{reviewer_selector 'assign-reviewers', @reviewers}
			</div>
			
			<input type='submit' class='jqBtn submitBtn'/>
DIV
	html << form_tag('/assign_review/assign_reviewers', :id => 'assign-reviews-form', :method => :post) do 
				inside_div.html_safe 
			end
	html << "</div>"
	html.html_safe
end

def auto_assign_reviews_dialog_helper
	html =<<HTML
		<div class='dialog'>
HTML
	inside_div=<<DIV
			Criteria: 
			<select name='criteria'>
				<option value='country'>Country</option>
				<option value='ra'>Research Area</option>
			</select>					
			<input type='submit' class='jqBtn'/>
DIV
	html << form_tag('/assign_review/auto_assign', :id => 'auto-assign-reviews-form', :method => :post) do 
				inside_div.html_safe 
			end
	html << "</div>"
	html.html_safe
end

end

