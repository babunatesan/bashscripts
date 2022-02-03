#For git all project in gorup | Downalod a specific file and save to another filename and redirect the content to another file
for word in $(cat project-list-pp.txt);
do
  echo $word;
  REPO_NAME=`echo $word | cut -d/ -f5`
  PP_PROJ_LIST="gitlab-project-requirements-txt-pp.txt"
  wget -O $REPO_NAME-requirements.txt $word/-/raw/master/requirements.txt
  cat $REPO_NAME-requirements.txt >> $FP_PROJ_LIST
  echo "" >> $PP_PROJ_LIST
done
