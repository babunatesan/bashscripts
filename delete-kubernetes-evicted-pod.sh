# we need change the namespace, replace the namespace next -n [digimops] to your namespace.
kubectl get pod -n {namespace} | grep Evicted | awk '{print $1}' | xargs kubectl delete pod -n {namespace}
