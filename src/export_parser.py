import os
import json
import sys

nodes_path = '../nodes/'

# Reading data from export config
with open(nodes_path+'export.json', 'r') as f:
    data = json.load(f)

#extract config from data
data = data['configs']
with open(nodes_path+'config.json', 'w') as f:
    json.dump(data, f)

#get json_list
with open(nodes_path+'config.json', 'r') as f:
	json_list = json.load(f)

for i in range(len(json_list)):
	with open(nodes_path+'config'+str(i)+'.json', 'w') as f:
		json.dump(json_list[i], f)

print(i)
