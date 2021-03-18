#!/bin/bash

# export KUBECONFIG=~/coderepos/openshift_cluster_config
# export IMAGE=docker.io/pprokopi/jws-operator:v0.0.9-support-5.3
# export NAMESPACE="jws-operator"

# oc delete deployment jws-operator || true
# oc process -f deploy/openshift_operator.template IMAGE=${IMAGE} | oc create -f -
# oc process -f deploy/operator.yaml IMAGE=${IMAGE} | oc create -f -
# oc delete webserver.web.servers.org/example-webserver || true
# oc apply -f deploy/crds/web.servers.org_webservers_cr.yaml
