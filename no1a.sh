#!/bin/bash

awk '
BEGIN {FS = "\t"}

{
if($13 != "Region") tmp[$13]+=$21
}

END{
low=100000
for(a in tmp){
  if(tmp[a]<low){
    low=tmp[a]
    lowestReg=a
  }
}
print "lowest profit region : ", lowestReg, low

}
' Sample-Superstore.tsv
