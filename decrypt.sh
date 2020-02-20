now=$(($(date +%H)+2))
echo $num| tr $(printf %${now}s | tr ' ' '.')\A-Z A-ZA-Z | tr $(printf %${now}s | tr ' ' '.')\a-z a-za-z > /home/afif/sisop/mod/afif.txt
