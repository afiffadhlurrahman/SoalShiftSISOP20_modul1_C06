#!/bin/bash

mkdir kenangan
mkdir duplicate

cat wget.log | grep Location: > location.log

awk 'BEGIN{num=0}
{
 print $2 
}
' location.log | 
awk 'BEGIN{n=0}
{
 n++;
 arr[$1]++
 if(arr[$1]>1) com = "mv pdkt_kusuma_" n " duplicate/duplicate_" n
 else com = "mv pdkt_kusuma_" n " kenangan/kenangan_" n 
 
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
 
