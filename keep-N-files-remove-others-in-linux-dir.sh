#it will keep 11 folder in directory and remove others.
ls -dt */ | tail -n +11 | -regex "\.\/[0-9]*" | xargs rm -rf
