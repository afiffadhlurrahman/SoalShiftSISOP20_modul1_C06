# SoalShiftSISOP20_modul1_C06
## Nama : Afif dan Vincent (C06)

## Soal 1

Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum
untuk membuat laporan berdasarkan data yang ada pada file “Sample-Superstore.tsv”.
Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa :
**[a]. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling
sedikit
[b]. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling
sedikit berdasarkan hasil poin a
[c]. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling
sedikit berdasarkan 2 negara bagian (state) hasil poin b
Whits memohon kepada kalian yang sudah jago mengolah data untuk mengerjakan
laporan tersebut.**
*Gunakan Awk dan Command pendukung

## Penyelesaian 
Penyelesaian nomor 1a, 1b, dan 1c menggunakan Awk
### Penyelesaian soal 1.a
```
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
```
BEGIN hanya akan berjalan sekali sebelum mulai. Didalam BEGIN terdapat `FS="\t"` yang menunjukan Field Separatornya adalah tab.
```
{
if($13 != "Region") tmp[$13]+=$21
}
```
Kemudian array `tmp[]` digunkanan untuk memasukan nilai profit(diambil dari kolom $21) dari setiap region dengan indexnya berupa nama region(diambil dari kolom $13). Penggunaan `if($13 != "Region")` untuk mengambil data tanpa judul tabelnya.

END hanya akan berjalan sekali setelah proses selesai. Didalam END terdapat loop untuk setiap region didalam array, dan dicari region yang memiliki profit paling rendah diantara region-region yang ada di dalam array `tmp[]`. 
```
if(tmp[a]<low){
    low=tmp[a]
    lowestReg=a
  }
```
nilai `tmp[a]` dimasukan ke `low` lalu dibandingkan dengan nilai `tmp[a]` lainnya. dan jika didapatkan nilai yang lebih rendah, lalu akan dimasukan ke `low`. proses ini dilakukan secara berulang hingga mendapatkan profit terendah

Setelah loop selesai, didapat profit terendah dan nama regionnya yang kemudian akan di print.

### Penyelesaian soal 1.b
penyelesaian soal 1.b mirip dengan penyelesaian soal 1.a
```
#!/bin/bash

awk '
BEGIN {FS = "\t" }
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
```
BEGIN hanya akan berjalan sekali sebelum mulai. Didalam BEGIN terdapat FS="\t" yang menunjukan Field Separatornya adalah tab.
```
{
 if($13 ~ /^Central/){
  tmp[$11]+=$21;
 }
}
```
Kemudian array tmp[] digunkanan untuk memasukan nilai profit(diambil dari kolom $21) dari setiap state dengan indexnya berupa nama state(diambil dari kolom $11). Penggunaan if($13 ~ /^Central/) untuk mengambil data dari region Central, karena Central merupakan hasil region dengan profit terendah dari hasil 1.a

END hanya akan berjalan sekali setelah proses selesai. Didalam END terdapat loop untuk setiap state didalam array, dan dicari state yang memiliki profit paling rendah diantara semua state yang ada di dalam array tmp[]. dalam loop ini juga disimpan data profit terkecil kedua dan nama statenya. Setelah loop selesai, didapat profit terendah pertama dan kedua dan nama regionnya yang kemudian akan di print.

### Penyelesaian soal 1.c
```
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
```
BEGIN hanya akan berjalan sekali sebelum mulai. Didalam BEGIN terdapat FS="\t" yang menunjukan Field Separatornya adalah tab.
```
{
if($11 ~ /^Texas/ || $11 ~ /^Illinois/){
arr[$17]+=$21
}
```
Kemudian array arr[] digunkanan untuk memasukan nilai profit(diambil dari kolom $21) dari setiap state dengan indexnya berupa nama product(diambil dari kolom $17). Penggunaan if($11 ~ /^Texas/ || $11 ~ /^Illinois/) untuk mengambil data dari state Texas atau Illinois, karena 2 state tersebut merupakan state dengan profit terendah dari hasil 1.b
```
| sort -g | head -10
```
Disini, digunakan sort -g (general number sort) untuk mengurutkan semua data yang di print di kolom pertama sehingga bisa didapatkan product dengan profit terendah hingga tertinggi. Karena di soal hanya diminta 10 product dengan profit terendah, maka digunakan head -10 untuk mengambil 10 data pertama.

## Soal 2

Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan
data-data penting. Untuk mencegah kejadian yang sama terulang kembali mereka
meminta bantuan kepada Whits karena dia adalah seorang yang punya banyak ide.
Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide
tersebut cepat diselesaikan. Idenya adalah kalian **(a) membuat sebuah script bash yang
dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf
besar, huruf kecil, dan angka. (b) Password acak tersebut disimpan pada file berekstensi
.txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.
(c) Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di
enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan
dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal:
password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt
dengan perintah ‘bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan
file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula
seterusnya. Apabila melebihi z, akan kembali ke a, contoh: huruf w dengan jam 5.28,
maka akan menjadi huruf b.) dan (d) jangan lupa untuk membuat dekripsinya supaya
nama file bisa kembali.**
HINT: enkripsi yang digunakan adalah caesar cipher.
*Gunakan Bash Script


## Penyelesaian

### Enkripsi

```
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
```
### Dekripsi
```
arg=$@
buat=$((26-$(date -d "@$(stat -c '%Y' /home/afif/sisop/mod/$arg.txt)" '+%H')))

echo $arg| tr $(printf %${buat}s | tr ' ' '.')\A-Z A-ZA-Z | tr $(printf %${buat}s | tr ' ' '.')\a-z a-za-z > /home/afif/sisop/mod/afif.txt

nama=$(cat /home/afif/sisop/mod/afif.txt)
mv /home/afif/sisop/mod/$arg.txt /home/afif/sisop/mod/$nama.txt
rm /home/afif/sisop/mod/afif.txt
```

## Pembahasan Enkripsi
`#!bin/bash` merupakan shebang untuk memulai menjalankan intepreter pada skrip bash.
`answer=$@` berfungsi untuk declare variable answer untuk menyimpan sementara argument yang diinputkan.
`p=${#answer}` berfungsi menghitung panjang string argument.
`a=$(expr "$answer" : "[A-Za-z]*$")`fungsi untuk menghitung panjang string yang mengandung alphabet atau huruf.

```
if [ $p -eq $a ]
then
```
untuk mengecek apakah argument yang diinputkan seluruhnya merupakan alphabet

`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1 > /home/afif/sisop/mod/$@.txt`
untuk men-generate random password (terdapat angka maupun huruf)

```
else
	echo "argument hanya berupa alphabet"
fi
```
jika argument terdapat char selain huruf maka program akan mengeluarkan output "argument hanya berupa alphabet" dan password tidak akan ter-generate

Untuk mengecek apakah semua isi dari argumen itu adalah alphabet. Jika iya, maka program akan generate password yang panjangnya 28 dan mengandung alphabet maupun numerik. Jika tidak, program akan mengeluarkan output "argumen hanya berupa alphabet".

`now=$(date +%H)` untuk mengetahui waktu ketika pembuatan file
```
echo $answer| tr $(printf %${now}s | tr ' ' '.')\A-Z A-ZA-Z | tr $(printf %${now}s | tr ' ' '.')\a-z a-za-z > /home/afif/sisop/mod/afif.txt
```
Untuk men-generate nama untuk file password (harus terdiri dari a-z dan A-Z) menggunakan pola yang sudah dijelaskan pada soal dan disimpan pada sebuah file untuk sementara.

```
num=$(cat /home/afif/sisop/mod/afif.txt)
```
Mengambil data dari file kemudian dimasukkan ke dalam sebuah variabel.

```
mv  /home/afif/sisop/mod/$answer.txt /home/afif/sisop/mod/$num.txt
```
Rename nama file awal menggunakan enkripsi yang sudah dibuat pada proses sebelumnya

```
rm /home/afif/sisop/mod/afif.txt
```
Untuk menghapus file sementara yang menyimpan nama file enkripsi


## Pembahasan Dekripsi
`arg=$@` untuk mengambil argument dan dimasukkan ke variable arg.
```
buat=$((26-$(date -d "@$(stat -c '%Y' /home/afif/sisop/mod/$arg.txt)" '+%H')))
```
Untuk mendapatkan tanggal kapan dibuat nya file, serta dikurangi 26 agar bisa kembali menjadi nama yang sama pada saat awal sebelum di enkripsi.
```
echo $arg| tr $(printf %${buat}s | tr ' ' '.')\A-Z A-ZA-Z | tr $(printf %${buat}s | tr ' ' '.')\a-z a-za-z > /home/afif/sisop/mod/afif.txt
```
Untuk memasukkan hasil nama file yang telah di dekripsi dan disimpan pada file sementara.
```
nama=$(cat /home/afif/sisop/mod/afif.txt)
```
Untuk memasukkan nama file ke dalam variable nama.
```
mv /home/afif/sisop/mod/$arg.txt /home/afif/sisop/mod/$nama.txt
```
Untuk mengganti nama file
```
rm /home/afif/sisop/mod/afif.txt
```
Untuk menghapus file sementara.

## Soal 3
1 tahun telah berlalu sejak pencampakan hati Kusuma. Akankah sang pujaan hati
kembali ke naungan Kusuma? Memang tiada maaf bagi Elen. Tapi apa daya hati yang
sudah hancur, Kusuma masih terguncang akan sikap Elen. Melihat kesedihan Kusuma,
kalian mencoba menghibur Kusuma dengan mengirimkan gambar kucing. **[a] Maka dari
itu, kalian mencoba membuat script untuk mendownload 28 gambar dari
"https://loremflickr.com/320/240/cat" menggunakan command wget dan menyimpan file
dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2,
pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam
sebuah file "wget.log". Karena kalian gak suka ribet, kalian membuat penjadwalan untuk
menjalankan script download gambar tersebut. Namun, script download tersebut hanya
berjalan [b] setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu Karena
gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan
gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma
sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar
identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda
antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian kirim ke
Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan
selalu menghibur Kusuma, jadi gambar yang telah terkirim tadi akan kalian simpan
kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi. [c] Maka dari
itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan
gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka
sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate
dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201).
Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan
dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253).**
Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi
ekstensi ".log.bak". Hint : Gunakan wget.log untuk membuat location.log yang isinya
merupakan hasil dari grep "Location".
*Gunakan Bash, Awk dan Crontab

## Penyelesaian
### penyelesaian 3a
```
#!bin/bash

for ((num=1; num<=28; num=num+1))
do
  wget -O pdkt_kusuma_$num -a wget.log "https://loremflickr.com/320/240/cat"
done
```
### penyelesaian 3b
```
5 6-23/8 * * 0-5 bash soal3.sh
```
### penyelesaian 3c
```
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
```
### Pembahasan
`#!bin/bash`  merupakan shebang untuk memulai menjalankan intepreter pada skrip bash.
```
for ((num=1; num<=28; num=num+1))
do
```
untuk melakukan perulangan sebanyak 28 kali yang nanti digunakan untuk mendowload 28 gambar.
```
wget -O pdkt_kusuma_$num -a wget.log "https://loremflickr.com/320/240/cat"
```
berfungsi untuk mendownload. `-O  pdkt_kusuma_$num` untuk me-rename nama file yang di download.`-a wget.log` untuk mendapatkan log dari hasil download.
`done` untuk menandakan akhir dari looping

```
5 6-23/8 * * 0-5 bash soal3a.sh
```
untuk melakukan crontab pada waktu yang telah ditentukan sesuai soal. menit ke 5 dari jam 6-23 berjalan setiap 8 jam hari minggu-jumat

untuk mengerjakan soal 3c, pertama kita buat directory baru,
`mkdir kenangan` untuk membuat directory baru bernama kenangan
`mkdir duplicate` untuk membuat directory bari bernama duplicate
```
cat wget.log | grep Location: > location.log
```
Fungsi diatas untuk mengambil data yang memiliki kata Location: dari file wget.log dan memasukannya ke file location.log dimana location ini akan digunakan untuk membandingkan gambar yang identik nantinya.

Setelah itu kita menggunakan awk untuk mencari gambar yang identik di file lokasi.log yang sudah kita buat tadi.

Kemudian setelah mendapat lokasi masing-masing gambae, kita masukan gambar ke array dengan lokasi gambar sebagai indexnya dan kita hitung ada berapa gambar yang memiliki lokasi yang sama. `arr[$1]++`. kita juga melakukan `n++` untuk memberi nomor/index pada masing-masing gambar. 

Jika terdapat gambar yang memiliki lokasi yang sama ( dalam hal ini `arr[$1]>1`) maka kita pindahkan gambar tersebut ke directory duplicate dengan `com = "mv pdkt_kusuma_" n " duplicate/duplicate_" n`

dan untuk gambar sisanya kita masukan ke directory kenangan dengan `com = "mv pdkt_kusuma_" n " kenangan/kenangan_" n ` 

lalu kita gunakan `system(com)` untuk menjalankannya pada perintah yang ada

```
ls *.log |
awk '
{
 com = "cp " $0 " " $0 ".bak"
 system(com)
}
' 
```
lalu terakhir kita mencari semua file yang memiliki extensi .log dengan `ls *.log` dan dengan menggunakan awk, kita copy(backup) semua file yang memiliki extensi .log dengan menggunakan extensi .log.bak.


