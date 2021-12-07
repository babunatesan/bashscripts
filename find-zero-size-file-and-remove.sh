#try before to use this command in other folder and test the commands
find ./ -type f -size 0
find ./ -type f -size 0 -exec rm -f {} \;
find ./ -type f -size 0 | xargs rm -f
find ./ -type f -size 0 -delete
