#!/bin/bash
export IMAGE=docker.io/pprokopi/jws-operator:v0.0.7-kubernetes
export NAMESPACE="jws-operator"

kubectl create namespace $NAMESPACE || true
kubectl config set-context --current --namespace=$NAMESPACE

kubectl delete -f deploy/crds/web.servers.org_webservers_crd.yaml -n $NAMESPACE || true
kubectl create -f deploy/crds/web.servers.org_webservers_crd.yaml -n $NAMESPACE || true
kubectl delete -f deploy/service_account.yaml -n $NAMESPACE || true
kubectl create -f deploy/service_account.yaml -n $NAMESPACE || true
kubectl delete -f deploy/role.yaml || true
kubectl create -f deploy/role.yaml
kubectl delete -f deploy/role_binding.yaml || true
kubectl create -f deploy/role_binding.yaml
kubectl delete deployment jws-operator || true
sed "s|@OP_IMAGE_TAG@|${IMAGE}|" deploy/kubernetes_operator.template >deploy/kubernetes_operator.yaml
kubectl apply -f deploy/kubernetes_operator.yaml
kubectl delete webserver.web.servers.org/example-webserver || true
kubectl apply -f deploy/crds/web.servers.org_webservers_cr.yaml

# kubectl delete ns ${NAMESPACE} --grace-period=0 --force
# kubectl delete namespace ${NAMESPACE} || true
# kubectl get namespace $NAMESPACE -o json > $NAMESPACE.json
# sed -i -e 's/"kubernetes"//' $NAMESPACE.json
# kubectl replace --raw "/api/v1/namespaces/$NAMESPACE/finalize" -f ./$NAMESPACE.json
