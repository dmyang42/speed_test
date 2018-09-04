#!/bin/zsh
# Program: 
cd all_config
python data_operation.py

chmod +x speed_test.sh
python speedtest.py
