#!/bin/sh
(
x=1
while [ $x -le 100 ]
do
	echo "ifconfig"
	x=$(( $x + 1 ))
	sleep 2
done
echo "exit"
) | telnet $1 $2 >> output_file.txt
