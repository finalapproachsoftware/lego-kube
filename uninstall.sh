#!/usr/bin/env bash
kubectl cluster-info > /dev/null 2>&1
if [ $? -eq 1 ]
then
  echo "kubectl was unable to reach your Kubernetes cluster. Make sure that" \
       "you have selected one using the 'gcloud container' commands."
  exit 1
fi

kubectl delete configmap lego-config --namespace=lego 2> /dev/null
kubectl delete deployment lego-server --namespace=lego 2> /dev/null
kubectl delete secret --all --namespace=lego 
kubectl delete ingress --all --namespace=lego 
