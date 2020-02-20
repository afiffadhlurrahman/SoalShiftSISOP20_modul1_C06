#!/bin/bash

awk '
BEGIN {FS = "\t"}

{
if($11 ~ /^Texas/ || $11 ~ /^Illinois/){
arr[$17]+=$21
}
}

END{
for(a in arr){
print arr[a], a
}
}
' Sample-Superstore.tsv | sort -g | head -10
