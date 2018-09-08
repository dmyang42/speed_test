#!/bin/zsh

nodes_path='./'
export_path=${nodes_path}'sample.json'

nodes=$(cat ${export_path} | jq ".configs")
length=$(cat ${export_path} | jq ".configs | length")
typeset -i length

curl_web="baidu.com"

out='out.txt'
if [ ! -n $out ]; then
    touch $out
else
    rm $out
    touch $out
fi

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

#    echo $server
#    echo $server_port
#    echo $local_address
#    echo $local_port
#    echo $password
#    echo $method
#    echo $timeout

    # connect to VPS
    sslocal -s $server -p $server_port -l $local_port -k\
        $password -m $method -q &
    export ALL_PROXY=socks5://127.0.0.1:1080
    sleep 0.5

    if_connect="fail"
    curl --connect-timeout 6 -m 8 -i $curl_web > /dev/null && if_connect="success"

    if [ "$if_connect" = "success" ]; then
        echo "Connected no.${i}"
        echo $server >> $out
        speedtest --simple >> $out
        echo >> './out.txt'
#        lsof -i:1080 | grep 'sslocal' | cut -d ' ' -f2 | xargs kill
        pkill sslocal
        echo "Finished no.${i}!"
    elif [ "$if_connect" = "fail" ]; then
        echo "Failed no.${i}"
        echo $server >> $out
        echo 'Failed' >> './out.txt'
        echo >> './out.txt'
#        lsof -i:1080 | grep 'sslocal' | cut -d ' ' -f2 | xargs kill
        pkill sslocal
    else
        echo "unkown situation!"
    fi
done
