echo "Enter the workernode name"
read worker
echo "Enter the namespace "
read namespace
kubectl get po -o wide -n $namespace | grep $worker | awk '{print $1}' | xargs -I{} kubectl top po {} -n $namespace --sort-by=memory
