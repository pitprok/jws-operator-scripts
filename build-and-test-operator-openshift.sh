#!/bin/bash
source ./test-variables-openshift.sh
oc delete namespace $NAMESPACE || true &
export DELETE_PID=$!

./test-operator-openshift.sh
