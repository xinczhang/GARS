module SortDialogHelper
def sort_dialog_helper
 	html =<<HTML
			<div class="dialog" id="sortDialog">
HTML
			
	insidediv =<<DIV
					<div class="dialogControls">
						<div class="controls">
							<input type="button" value="Add Level" id="sortAddLevelBtn"/>
							<input type="button" value="Delete Level" id="sortDelLevelBtn"/>
						</div>

    					<div class="okCancelControls">
							<input type="submit" value="Ok"/>
                        	<input type="button" value="Cancel"/>
                        </div>
                    </div>
	
	        <input type='hidden' id='sort-type' name='sort-type'/>
                <input type='hidden' id='sort-name' name='sort-name'/>
                <input type='hidden' id='sort-order' name='sort-order'/>
                    <ul>
			<li style="display:none;">
                            <span>Sort by:</span>
                            <select class='sort-type'>
                                <option value="ay">AY Data</option>
                                <option value="ots">OTS Data</option>
                            </select>
                            
                	    #{ay_selector 'sort-value ay'}
                	    #{ots_selector 'sort-value ots'}
				
			    <select class="sort-order">
				<option value="1">AES</option>
				<option value="-1">DES</option>
			    </select>
                       	</li>

                    	<li>
                            <span>Sort by:</span>
                            <select class='sort-type'>
                                <option value="ay">AY Data</option>
                                <option value="ots">OTS Data</option>
                            </select>
                            
                	    #{ay_selector 'sort-value ay'}
                	    #{ots_selector 'sort-value ots'}
			
			     <select class="sort-order">
				<option value="1">AES</option>
				<option value="-1">DES</option>
			    </select>

                       	</li>
                    </ul>
DIV
	html << form_tag('/view_table/view', :id => 'sort-form', :method => :get) do 
				insidediv.html_safe 
			end
	html << "</div>"
	html.html_safe
end
end
