#!/bin/sh
(
echo "ifconfig"
sleep 1
echo "iwconfig"
sleep 1
echo "exit"
) | telnet $1 $2 >> output_file.txt
