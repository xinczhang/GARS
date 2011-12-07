module AddRemoveFieldHelper
def remove_fields_dialog_helper
	html =<<HTML
			<div id="addRemoveFieldsDialog" title="Add/Remove Fields">
HTML
	inside_div=<<DIV
                
                <input type='hidden' id='add_remove_gars' name='add_remove_gars'/>
                <input type='hidden' id='add_remove_ay' name='add_remove_ay'/>
                <input type='hidden' id='add_remove_ots' name='add_remove_ots'/>

		<div class='section'>
			<div class='header'>
				<h2>GARS Data
			</div>
			<div class='content'>
				not implemented yet
			</div>
		</div>
		<div class='section'>
			<div class='header'>
				<h2>AY Data
			</div>
			<div class='content'>
				#{table_selectors 'ay'}
			</div>
		</div>
		<div class='section'>
			<div class='header'>
				<h2>OTS Data
			</div>
			<div class='content'>
				#{table_selectors 'ots'}
			</div>
		</div>
		
		<input type='submit' class='jqBtn submitBtn' value='change'/>
DIV
	html << form_tag('/view_table/add_remove_fields', :id => 'add-remove-fields-form', :method => :post) do 
				inside_div.html_safe 
			end
	html << "</div>"
	html.html_safe
end
def fields_display_helper ay, ots 
	first = true	
	line = ""
	session[:ay_display].each do |a|
		name = MAPPER.get_attr('ay',a)[:name]
                if ApplyYourself.method_defined? :"#{name}" 
                	value = ay.send(:"#{name}")
        		if first                        
				line +=	"<span class=\"appCountry\">" + value.to_s + "</span>"
				first = false
			else
				line +=  ", <span class=\"appCountry\">" + value.to_s + "</span>"
			end
		end
	end
	session[:ots_display].each do |o|
                name = MAPPER.get_attr('ots',o)[:name]
                if OfficialTestScore.method_defined? :"#{name}"
                	value = ots.send(:"#{name}")
                	if first
                       		line +=  "<span class=\"appCountry\">" + value + "</span>"
                        	first = false
			else
				line +=  ", <span class=\"appCountry\">" + value + "</span>"
                	end
		end
        end
	return line.html_safe
end
end

