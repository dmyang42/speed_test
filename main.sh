#!/bin/zsh
# Program: 
#    test speed of a set of nodes from cordcloud
#    generate test logs
#
# History:
#    2018/9/4 topol pp v1.0

cd all_config
python data_operation.py

chmod +x speed_test.sh
python speedtest.py
