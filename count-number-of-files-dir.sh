#vi dir_name.txt and add the direcoty names
#this script will print each dir name and number of files. 
#!/bin/bash
input="dir_name.txt"
while IFS= read -r line
do
  find $line -type f | wc -l > $line.txt
  echo `cat @line.txt`
done < "$input"
