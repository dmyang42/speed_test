#!/bin/zsh
sslocal -c ./config.json 
export ALL_PROXY=socks5://127.0.0.1:1080
speedtest --simple > ./out
echo 'Finished!'
