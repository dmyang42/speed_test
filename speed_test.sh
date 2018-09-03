#!/bin/zsh
sslocal -c ./config.json &
speedtest --simple > ./out
echo 'Finished!'
