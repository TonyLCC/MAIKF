#!/bin/bash

#dmesg -c > /tmp/dmesg.txt

# if $(pidof $1) = $2 then kill $2
#kill $(pidof $1)

#echo $1 > /tmp/pid.txt
kill $(echo "$1" | awk '{print $8 $9}' | jq .processInfo.pid)

if [[ $? = 0 ]]
then
#	echo $(date +%B" "%d" "%T) $(uname -n) "kernel: The specified process has been killed" >> /var/log/kern.log
	echo "The specified process has been killed : Beijing time:" $(date +%F" "%T) #>> /var/log/kern.log
else
	echo "Kill the specified process failed : Beijing time:" $(date +%F" "%T) #>> /var/log/kern.log
fi
