import os
import json
import sys

# Should write in Shell Script
length = int(sys.argv[1]) + 1
nodes_path = '../nodes/'
src_path = './'

for i in range(length):
	config_name = nodes_path +  'config' + str(i) + '.json'
	print('peer',i)
	os.system(src_path+'speed_test.sh '+config_name+' '+str(i) )
print('all finished')
