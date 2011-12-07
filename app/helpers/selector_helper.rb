module SelectorHelper
def user_selector
	user_selector = "<select class='filter-value' class='user' style='display:none;'>"
        users = User.all
	users.each do |u|
                        user_selector << "<option>".html_safe + u.name.html_safe + "</option>".html_safe
        end
        user_selector << "</select>"

end

# generate a <select></select> tag
def selector options, types, class_name, vis='inline-block'
	html = "<select class=\"#{class_name}\" style=\"display:#{vis};\">".html_safe
	options.each_with_index do |o , i|
		if(!types[i].nil?)
        	html << "<option data-type=\"#{types[i][:type]}\">".html_safe + o.html_safe + "</option>".html_safe
		else
		html << "<option>".html_safe + o.html_safe + "</option>".html_safe
		end
        end
	html << '</select>'.html_safe
end

def select_selectors map_name, class_name, vis='inline-block'
	attrs = MAPPER.get_map(map_name).keys.sort
	types = []
	attrs.each do |attr|
		types << MAPPER.get_attr(map_name, attr)
	end
	selector attrs, types, class_name, vis
end

def country_selector class_name
	html = '<label>Country: </label>'.html_safe
	options = ['China', 'USA']
	v = selector options, [] ,class_name
	html << v
end

def research_area_selector class_name
	html = '<label>Research Area: </label>'.html_safe
	options = []
	ResearchArea.all.each do |ra|
		options << ra.name
	end
	v = selector options, [], class_name
	html << v
end

def gars_selector class_name
	# select_selectors "gars"
	"<select><option>gars_selector: mapping has not been implemented</option></select>".html_safe
end

def ay_selector class_name
	select_selectors "ay", class_name
end

def ots_selector class_name
	select_selectors "ots", class_name, "none"
end

def reviewer_selector class_name, reviewers
	html = "<table class='tableSelector #{class_name}'>".html_safe
	reviewers.each do |r|
		k = r.name
		research_areas = []
		r.research_areas.each do |ra|
			research_areas << ra.name
		end
		html << '<tr>'.html_safe
		html << "<td><input type='checkbox' name='name[]' value='#{k.html_safe}' />".html_safe + "<a href='' class='appName'>#{k.html_safe}</a>".html_safe + '       '.html_safe + "<span>#{research_areas.join(',')}</span>".html_safe + "</td>".html_safe
		html << '</tr>'.html_safe
	end
	html << "</table>".html_safe	
end



def table_selectors map_name
	session_name = map_name + "_display"
	store =	session[:"#{session_name}"]

	ay_selector = "<table class='tableSelector #{map_name}'>".html_safe
        ay_attrs = MAPPER.get_map(map_name).keys.sort
	num_attr_per_row = 4
	ay_attrs.in_groups_of(num_attr_per_row, false) do |group|
		ay_selector << '<tr>'.html_safe
		group.each do |k|
			if(!store.nil? && store.include?(k))
				ay_selector << "<td><input type='checkbox' name='#{k.html_safe}' value='#{map_name}' checked/>".html_safe + "<label>#{k.html_safe}</label>".html_safe + "</td>".html_safe
			else
				ay_selector << "<td><input type='checkbox' name='#{k.html_safe}' value='#{map_name}' />".html_safe + "<label>#{k.html_safe}</label>".html_safe + "</td>".html_safe
			end
        	end
		ay_selector << '</tr>'.html_safe
	end
	ay_selector << "</table>".html_safe
end

end
