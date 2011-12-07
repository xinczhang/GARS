require "/home/jiayu/Documents/GARS/app/lib/mapper.rb"

CONFIG = "public/data/config/"
PATH = {:ay=>CONFIG+"ay-map.txt", :ots=>CONFIG+"ots-map.txt", :institution=>CONFIG+"institution-map.txt"}

MAPPER = Mapper.instance
MAPPER.init(:ay=>PATH[:ay], :ots=>PATH[:ots], :institution=>PATH[:institution])
