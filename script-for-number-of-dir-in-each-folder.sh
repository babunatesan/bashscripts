#This script will print each dir name and number of files. minio-dir.txt --> copy the main directory names
#!/bin/bash
input="minio-dir.txt"
while IFS= read -r line
do
  #find $line -type f | wc -l > $line.txt
  #echo `cat @line.txt`
  find $line/<BBBB/NNNNNNN -mindepth 1 -type d | wc -l > line1.txt
  echo $line
  echo `cat line1.txt`
done < "$input"
