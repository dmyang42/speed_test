#!/bin/zsh
# Program:
# do the connecting work and test work
# after testing, kill the process

sslocal -c ${1} &
export ALL_PROXY=socks5://127.0.0.1:1080
speedtest --simple > "../nodes/out${2}.txt"
echo "Finished no.${2}!"
lsof -i:1080 | grep 'sslocal' | cut -d ' ' -f2 | xargs kill
