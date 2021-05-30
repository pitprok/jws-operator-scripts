#!/bin/bash
tail --pid=$DELETE_PID -f /dev/null

kubectl create namespace $NAMESPACE || true
kubectl config set-context --current --namespace=$NAMESPACE

kubectl delete -f deploy/crds/web.servers.org_webservers_crd.yaml -n $NAMESPACE || true

make run-kubernetes

# kubectl apply -f deploy/crds/web.servers.org_webservers_cr.yaml
# kubectl apply -f deploy/crds/web.servers.org_webservers_cr_build_webapp_full.yaml
kubectl apply -f deploy/crds/web.servers.org_webservers_cr_build_webapp_minimal.yaml