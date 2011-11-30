module FilterDialogHelper
def filter_helper

 	html = <<HTML
<div class="dialog" id="filterDialog" style="display: none;">
HTML
	insidediv =<<DIV
                    <div class="dialogControls" id="">
			<div class="dialogControls">
				<div class="controls">
					<input type="button" value="Add" id="filterAddBtn"/>
					<input type="button" value="Delete" id="filterDelBtn"/>
				</div>

    				<div class="okCancelControls">
					<input type="submit" value="Ok"/>
        	                	<input type="button" value="Cancel"/>
        	                </div>
       		            </div>

                    </div>

			<input type='hidden' id='select-type' name='select-type'/>
                	<input type='hidden' id='select-sql-type' name='select-sql-type'/>
                	<input type='hidden' id='select-name' name='select-name'/>
			<input type='hidden' id='select-value' name='select-value' />
			<input type='hidden' id='select-op' name='select-op' />

			<ul>
			<li  style="display:none;">
                            <span>Filter by:</span>
                            <select class="filter-type">
                                <option selected="selected" value="ay">AY Data</option>
                                <option value="ots">OTS Data</option>
                            </select>

                            
			    #{ay_selector 'filter-value ay'}
			    #{ots_selector 'filter-value ots'}
			
			    <input type="text" class="filter-content" />
			    <select class="op" style="display:none;">
				<option value="-1">&lt;</option>
				<option value="0">=</option>
				<option value="1">&gt;</option>
			    </select>
                       	</li>

			

                    	<li>
                            <span>Filter by:</span>
                            <select class="filter-type">
                                <option selected="selected" value="ay">AY Data</option>
                                <option value="ots">OTS Data</option>
                            </select>

                            
			    #{ay_selector 'filter-value ay'}
			    #{ots_selector 'filter-value ots'}
			
			    <input type="text" class="filter-content" />
			    <select class="op" style="display:none;">
				<option value="-1">&lt;</option>
				<option value="0">=</option>
				<option value="1">&gt;</option>
			    </select>
                       	</li>
                    </ul>
DIV
	html << form_tag('/view_table/filter', :id => 'filter-form', :method => :post) do insidediv.html_safe
end
	html << "</div>"
	
html.html_safe
end
end
