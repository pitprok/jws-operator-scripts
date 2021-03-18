#!/bin/bash -x
kubectl delete namespace ${NAMESPACE}  --grace-period=0 --force &
eval $(minikube docker-env)
export IMAGE=docker.io/pprokopi/jws-operator:v0.0.7-kubernetes

make push
export NAMESPACE="jws-operator"
kubectl delete all --all
kubectl delete all --all
kubectl delete all --all

kubectl get namespace "jws-operator" -o json \
  | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/" \
  | kubectl replace --raw /api/v1/namespaces/jws-operator/finalize -f -

./test-operator-kubernetes.sh
