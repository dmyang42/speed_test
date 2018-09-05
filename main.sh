#!/bin/zsh
# Program: 
#    test speed of a set of nodes from cordcloud
#    generate test logs
#
# History:
#    2018/9/4 topol pp v0.2

cd src
len=`python export_parser.py`

chmod +x speed_test.sh
python speed_test.py $len
