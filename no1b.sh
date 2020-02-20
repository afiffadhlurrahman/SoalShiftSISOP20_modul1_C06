#!/bin/bash

awk '
BEGIN {FS = "\t" ; n=0}

{
 if($13 ~ /^Central/){
  tmp[$11]+=$21;
 }
}

END{
min=10000000
for(a in tmp){
  secMin=tmp[a]
  secState=a
  if(tmp[a]<min){
    min=tmp[a]
    firstState = a;
  }
}

print "first lowest : ", firstState,min
print "second lowest : ", secState, secMin

}
' Sample-Superstore.tsv
