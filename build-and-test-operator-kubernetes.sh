#!/bin/bash -x
source ./test-variables-openshift.sh
kubectl delete namespace $NAMESPACE || true &
export DELETE_PID=$!

./test-operator-kubernetes.sh
