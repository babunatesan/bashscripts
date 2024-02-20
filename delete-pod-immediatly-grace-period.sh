##$1-podname-#2-namespace
kubectl delete pod $1 --grace-period=0 --force --namespace $2 
