arg=$@
buat=$((26-$(date -d "@$(stat -c '%Y' /home/afif/sisop/mod/$arg.txt)" '+%H')))

echo $arg| tr $(printf %${buat}s | tr ' ' '.')\A-Z A-ZA-Z | tr $(printf %${buat}s | tr ' ' '.')\a-z a-za-z > /home/afif/sisop/mod/afif.txt

nama=$(cat /home/afif/sisop/mod/afif.txt)
mv /home/afif/sisop/mod/$arg.txt /home/afif/sisop/mod/$nama.txt
rm /home/afif/sisop/mod/afif.txt	
