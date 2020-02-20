#!bin/bash

answer=$@
p=${#answer}
a=$(expr "$answer" : "[A-Za-z]*$")

if [ $p -eq $a ]
then
	cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1 > /home/afif/sisop/mod/$@.txt
else
	echo "argument hanya berupa alphabet"
fi
