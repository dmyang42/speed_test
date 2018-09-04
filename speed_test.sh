#!/bin/zsh
# Program:
#   connect shadowsocks with config.json
#   test the speed and output test log
#
# History:
#   2018/9/4 topol v0.1

sslocal -c ./config.json &
echo 'ss connected!'

export ALL_PROXY=socks5://127.0.0.1:1080
echo 'proxy set!'

speedtest --simple > ./out
echo 'speed test finished!'

# lsof -i:1080 - process in port 1080
# grep 'sslocal' - lines representing sslocal process
# cut -d ' ' -f2 - pick out the second column: 
#    sslocal 5165 topol    4u  IPv4  57653 ...
# xargs kill - kill sslocal process
lsof -i:1080 | grep 'sslocal' | cut -d ' ' -f2 | xargs kill
