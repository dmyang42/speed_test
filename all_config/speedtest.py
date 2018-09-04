import os
import json
import sys

# 140海星
# Should write in Shell Script
for i in range(140):
	config_name = 'config' + str(i) + '.json'
	print('peer',i)
	os.system('./speed_test.sh '+config_name+' '+str(i) )
print('all finished')
