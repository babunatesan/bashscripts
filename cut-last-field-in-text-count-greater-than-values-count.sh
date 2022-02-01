#test.ext
44#sween#22
56#pop#23
66#savit#32
77#kavi#45
66#lori#26

#Script
cut -d# -f3- test.txt > number.txt
awk '$1>25{c++} END{print c+0}' number.txt
