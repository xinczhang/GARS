require 'singleton'
class Mapper
	include Singleton

	#parameter :ay=>ay_file, :ots=>ots_file
	def init(hsh = {})
		@map = Hash.new
		@otherinfo = Hash.new
		@sqlmap = Hash.new
	
		hsh.each { |k,v|
			init_file_mapping(k.to_s, v)
			init_sql_mapping(k.to_s)
		}
	end
	
	#parameter :ay=>ay_file, :ots=>ots_file
	def update(hsh = {})
		hsh.each { |k,v|
			init_file_mapping(k.to_s, v)
			init_sql_mapping(k.to_s)
		}
	end

	#parameter type	
	def get_map(type)
		@map[type]
	end
	
	def get_otherinfo(type)
		@otherinfo[type]
	end

	#ay, ots
	#get corresponding sql column for data field of type
	def get_attr(type, field)
		case type
		when "ay","ots"
			sql_column_name = @map[type][field]
			sql_column_type = @sqlmap[type][sql_column_name]
		else
		end
		return {:name=>sql_column_name, :type=>sql_column_type}
	end

	#ay, ots
	#get corresponding list of data fields for displaying
	def get_attr_list(type)
		case type
		when "ay" , "ots"
			@map[type].keys.sort
		else
		end	
	end

	def init_file_mapping(type, file)
		if(File.exist? file)
		@map[type] = m1 = Hash.new
		@otherinfo[type] = m2 = []
		File.open(file, "r") do |f|
			while(line = f.gets)
				if(!line.nil? && !line.index("->").nil?)
				rule = line.split("->")
				l,r = rule[0],rule[1].chomp
				if(r.eql?("otherInfo"))
					m2  << l
				end
				m1[l] = r
				end
			end
		end
		end
	end

	def init_sql_mapping(type)
		case type
		when "ay"
			@sqlmap["ay"] = m = Hash.new
			ApplyYourself.columns.each { |c|
				m[c.name] = c.type
			}			
		when "ots"
			@sqlmap["ots"] = m = Hash.new
			OfficialTestScore.columns.each { |c|
				m[c.name] = c.type
			}			
		else
		end
	end

	public :update, :get_map, :get_attr, :get_attr_list, :get_otherinfo
	private :init_sql_mapping, :init_file_mapping
end
