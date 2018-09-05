import os
import json
import sys

# Reading data from export config
with open('export.json', 'r') as f:
    data = json.load(f)

#extract config from data
data = data['configs']
with open('config.json', 'w') as f:
    json.dump(data, f)

#get json_list
with open('config.json', 'r') as f:
	json_list = json.load(f)

for i in range(len(json_list)):
	with open('config'+str(i)+'.json', 'w') as f:
		json.dump(json_list[i], f)