#!/usr/bin/env bash
kubectl cluster-info > /dev/null 2>&1
if [ $? -eq 1 ]
then
  echo "kubectl was unable to reach your Kubernetes cluster. Make sure that" \
       "you have selected one using the 'gcloud container' commands."
  exit 1
fi

#create namespace
kubectl get namespace lego > /dev/null 2>&1
if [ $? -eq 1 ]
then
  echo "Could not find the lego namespae.  Createing it now..."
  kubectl create -f templates/namespace.yaml
fi

# Clear out any existing configmap. Fail silently if there are none to delete.
kubectl delete configmap lego-config --namespace=lego 2> /dev/null
if [ $? -eq 1 ]
then
  echo "Before continuing, make sure you've used the provided template to create a configmap.yaml for your environment"
  echo
  read -p "<Press enter once you've made your configmap file>"
fi
kubectl create -f configmap.yaml

kubectl delete deployment lego-server --namespace=lego 2> /dev/null
kubectl create -f templates/server.yaml
echo
echo "===== Lego Server installed ============================================"