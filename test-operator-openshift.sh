#!/bin/bash
./test-variables.sh
tail --pid=$DELETE_PID -f /dev/null
oc new-project $NAMESPACE

oc delete -f xpaas-streams/jws54-tomcat9-image-stream.json -n openshift || true
oc delete crd webservers.jwsservers.web.servers.org || true
oc delete crd webservers.web.servers.org || true
oc delete crd jwsservers.web.servers.org || true
oc delete -f deploy/crds/web.servers.org_webservers_crd.yaml -n $NAMESPACE || true
oc delete -f deploy/service_account.yaml -n $NAMESPACE || true
oc delete -f deploy/role.yaml || true
oc delete -f deploy/role_binding.yaml || true
oc delete deployment jws-operator || true
oc delete webservers.web.servers.org/example-image-webserver || true
oc delete webservers.web.servers.org/example-imagestream-webserver || true

oc create -f xpaas-streams/jws54-tomcat9-image-stream.json -n openshift || true
make run-openshift
# oc apply -f deploy/crds/web.servers.org_webservers_imagestream_sources_cr.yaml
# oc apply -f deploy/crds/web.servers.org_webservers_imagestream_cr.yaml
oc apply -f deploy/crds/web.servers.org_webservers_cr.yaml
# trash -r build/_output/
