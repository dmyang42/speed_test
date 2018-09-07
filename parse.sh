#!/bin/zsh

nodes_path='./'
export_path=${nodes_path}'sample.json'

nodes=$(cat ${export_path} | jq ".configs")
length=$(cat ${export_path} | jq ".configs | length")
typeset -i length

export ALL_PROXY=socks5://127.0.0.1:1080
for (( i=0; i<$length; i=i+1 ))
do
    server=$(echo $nodes | jq ".[$i].server");\
        server=${server#\"};\
        server=${server%\"};
    
    server_port=$(echo $nodes | jq ".[$i].server_port");\
        server_port=${server_port#\"};\
        server_port=${server_port%\"};
    
    # local_address=$(echo $nodes | jq ".[$i].local_address")

    # local_port default : 1080
    # local_port=$(echo $nodes | jq ".[$i].local_port")
    local_port=1080

    password=$(echo $nodes | jq ".[$i].password");\
        password=${password#\"};\
        password=${password%\"};

    method=$(echo $nodes | jq ".[$i].method");\
        method=${method#\"};\
        method=${method%\"};

    timeout=$(echo $nodes | jq ".[$i].timeout")

    declare -i server_port
    # declare -i local_port
    declare -i timeout

    # echo $server
    # echo $server_port
    # echo $local_address
    # echo $local_port
    # echo $password
    # echo $method
    # echo $timeout

    # connect to VPS
    sslocal -s $server -p $server_port -l $local_port -k\
        $password -m $method -q &
    echo "Connected no.${i}"

    # test proxy speed
    speedtest --simple > "./out${i}.txt"

    # kill sslocal process
    lsof -i:1080 | grep 'sslocal' | cut -d ' ' -f2 | xargs kill

    echo "Finished no.${i}!"
done

