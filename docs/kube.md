# Random kube notes

Get the external-ip, cluster-ip and age for all in the namespace
```
kubectl get svc -o wide
```

The same but with -o json gives full details, can be limited to individual app
```
kubectl get svc <app name> -o json
```
