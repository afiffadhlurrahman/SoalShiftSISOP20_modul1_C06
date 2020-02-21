#!bin/bash

#no3a
for ((num=1; num<=28; num=num+1))
do
  wget -O pdkt_kusuma_$num -a wget.log "https://loremflickr.com/320/240/cat"
done

#no 3c
mkdir kenangan
mkdir duplicate

cat wget.log | grep Location: > location.log

awk 'BEGIN{num=0}
{
 print $2 
}
' location.log | 
awk 'BEGIN{n=0;j=0;k=0}
{
 n++;
 arr[$1]++
 if(arr[$1]>1) {
	j++
	com = "mv pdkt_kusuma_" n " duplicate/duplicate_" j
 }
 else {
	k++;
	com = "mv pdkt_kusuma_" n " kenangan/kenangan_" k
 }
 
 system(com)
}
'

ls *.log |
awk '
{
 com = "cp " $0 " " $0 ".bak"
 system(com)
}
' 
