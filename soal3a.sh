#!bin/bash

for ((num=1; num<=28; num=num+1))
do
  wget -O pdkt_kusuma_$num -a wget.log "https://loremflickr.com/320/240/cat"
done
