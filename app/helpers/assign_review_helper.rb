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
				<div id='reviewerPagination' class="pagination">
					<a href='#' class='jqBtn'>Prev</a>
					<a href='#' class='jqBtn'>Next</a>
				</div>	
			</div>
			<div class='content' style='padding:0px'>
				#{reviewer_selector 'assign-reviewers'}
			</div>
			
			<input type='submit' class='jqBtn submitBtn'/>
DIV
	html << form_tag('/assign_review', :id => 'assign-reviews-form', :method => :post) do 
				inside_div.html_safe 
			end
	html << "</div>"
	html.html_safe
end
end
