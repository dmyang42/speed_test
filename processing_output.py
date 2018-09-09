import csv

f = open('out.txt', 'r')
print(f.name)
index = 0
tmp_server = {}
server_list = [] #save servers' data

#data operation
while True:
	line = f.readline()
	if not line:
		server_list.append(tmp_server.copy())
		break
	if line[0] == '\n':
		server_list.append(tmp_server.copy())

	line = line.split(' ', 1)
	if len(line) == 1:
		tmp_server['Server'] = line[0].rstrip('\n')
	else:
		tmp_server[line[0].rstrip(':')] = line[1].rstrip('\n')

list_length = len(server_list)
#sort

#by download speed
sorted_by_Download = sorted( server_list, key=lambda server : float(server['Download'].split(' ', 1)[0]), reverse=True )
#by upload speed
sorted_by_Upload = sorted( server_list, key=lambda server : float(server['Upload'].split(' ', 1)[0]), reverse=True )
#by Ping
sorted_by_Ping = sorted( server_list, key=lambda server : float(server['Ping'].split(' ', 1)[0]), reverse=True )


#get score by a certain method
#score_method is a list like [0.2, 0,8]
'''
def get_score(self, score_method):
	score = {}
	for server in sorted_by_Ping:
		score[server['Server']] =
'''
score_method = [0.2, 0.8]
score = {}
for ping_rank in range(list_length):
	server_name = sorted_by_Ping[ping_rank]['Server']
	download_rank = sorted_by_Download.index(sorted_by_Ping[ping_rank])
	score[server_name] = (list_length - ping_rank) * score_method[0] + (list_length - download_rank) * score_method[1]

print(score)

#write data into csv file
'''
with open('dict.csv', 'w') as csvfile:
	#name = server_list[0].keys()
	#or write in order
	name = ['Server', 'Ping', 'Download', 'Upload']
	writer = csv.DictWriter(csvfile, fieldnames=name)
	writer.writeheader()
	for i in server_list:
		writer.writerow(i)
'''
