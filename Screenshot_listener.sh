#!/bin/bash
SERVICE="geckodriver"  #select a service for starting script
path="~/script/TestAutomation" #script's location
filename=$1
echo $filename
SECOUNDS=0
num=0
pkill -f firefox #close all firefox before start selenium
pkill -f geckodriver #close all geckodriver before start selenium
output=$(which scrot) #Checks whether "scrot" is installed.
if echo "$output" | grep 'bin'; then
  echo "VPC has scrot"
else
  echo "VPC has not scrot"
  echo "install process starting"
  sudo apt-get --assume-yes install scrot #If it is not installed, it performs the installation process.
fi

output=$(which ffmpeg) #Checks whether "ffmpeg" is installed.
if echo "$output" | grep 'bin'; then
  echo "VPC has ffmpeg"
else
  echo "VPC has not ffmpeg"
  echo "install process starting"
  sudo apt-get --assume-yes install ffmpeg #If it is not installed, it performs the installation process.
  
fi

while :
do
   echo "$SERVICE is not running"
   sleep 2 #Check whether the service starts every two seconds.
   SECOUNDS=$((SECOUNDS+1))
   echo "$SECOUNDS"
   if (pgrep -x "$SERVICE" >/dev/null || [ "$SECOUNDS" -gt 99 ]); #If it does not start within 100 seconds, the script terminate.
   then
	break
   fi
done

if [ "$SECOUNDS" -ne 100 ];
   then
	while :
	do
	   echo "capture a screenshot"
	   echo $ekran
	   DISPLAY=:10.0 scrot 'image_'$num'.jpeg' -e 'mv $f '$path'' #I have set the most appropriate screen image format as jpeg for minimum CPU usage(lubuntu VPC).
	   sleep 1.7  ### important !! DISPLAY=:10.0 must change ! you can learn your own display value with "echo $DISPLAY"
	   num=$((num+1)) #take screenshot process started.
	   echo "$num"
	   if ([ $num -gt 35 ] && ! pgrep -x "$SERVICE" >/dev/null)
	   then
		sleep 1 #even after the service is turned off, it takes 4 screenshots.
		DISPLAY=:10.0 scrot -e 'mv $f '$path''
		sleep 1  
		DISPLAY=:10.0 scrot -e 'mv $f '$path''
		sleep 1
		DISPLAY=:10.0 scrot -e 'mv $f '$path''
		sleep 1
		DISPLAY=:10.0 scrot -e 'mv $f '$path''
		sleep 1
		echo "EkremBeyKazandi"
		ffmpeg -framerate 2 -i image_%d.jpeg -vcodec libx264 -x264-params crf=47 -preset veryfast -acodec copy  $filename.mp4 #Processes the images named "image_% d" and converts them to mp4.
		rm image_*  #delete old images
		break
	   fi
	done
else
break
echo "$SERVICE is not started"
echo "Script terminating."
fi


set -o errexit 
