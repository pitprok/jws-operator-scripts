#!/bin/bash
source ./test-variables.sh
oc delete namespace $NAMESPACE || true &
export DELETE_PID=$!
make push
./test-operator-openshift.sh
