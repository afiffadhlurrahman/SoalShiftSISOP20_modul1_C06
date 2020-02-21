#!bin/bash

answer=$@
p=${#answer}
a=$(expr "$answer" : "[A-Za-z]*$")

if [ $p -eq $a ]
then
	cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1 > /home/afif/sisop/mod/$@.txt
else
	echo "argument hanya berupa alphabet"
fi

now=$(date +%H)

echo $answer| tr $(printf %${now}s | tr ' ' '.')\A-Z A-ZA-Z | tr $(printf %${now}s | tr ' ' '.')\a-z a-za-z > /home/afif/sisop/mod/afif.txt

num=$(cat /home/afif/sisop/mod/afif.txt)

mv  /home/afif/sisop/mod/$answer.txt /home/afif/sisop/mod/$num.txt

rm /home/afif/sisop/mod/afif.txt
