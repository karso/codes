###########################
###	Soumitra Kar	###
###			###
###########################

import json


jfile = open('apprity_properties.json', 'r') 
line = jfile.read()
jline = json.loads(line)
array_of_dics = jline['apprity_properties_common']
for item in array_of_dics:
	if item['key'] == 'spark.executor.memory':
		print item['val']

