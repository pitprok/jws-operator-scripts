#!/bin/bash
tail --pid=$DELETE_PID -f /dev/null

oc new-project $NAMESPACE

oc delete -f xpaas-streams/jws54-tomcat9-image-stream.json -n openshift || true
oc create -f xpaas-streams/jws54-tomcat9-image-stream.json -n openshift || true

oc delete -f deploy/crds/web.servers.org_webservers_crd.yaml -n $NAMESPACE || true

make run-openshift

oc apply -f deploy/crds/web.servers.org_webservers_cr_build_webapp_minimal.yaml
