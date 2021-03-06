#!/bin/bash

for namespace in $(oc get namespace -l sleep-at-night=yes -o jsonpath='{.items[*].metadata.name}')
do
  for deployment in $(oc get deployments -n $namespace -o jsonpath='{.items[*].metadata.name}')
  do
    oc scale deployments $deployment --replicas=0 -n $namespace
  done
  for statefulset in $(oc get statefulset -n $namespace -o jsonpath='{.items[*].metadata.name}')
  do
    oc scale statefulsets $statefulset --replicas=0 -n $namespace
  done
  for deploymentconfig in $(oc get deploymentconfig -n $namespace -o jsonpath='{.items[*].metadata.name}')
  do
    oc scale deploymentconfigs $deploymentconfig --replicas=0 -n $namespace
  done
  for replicaset in $(oc get replicaset -n $namespace -o jsonpath='{.items[*].metadata.name}')
  do
    if [[ $(oc get replicaset $replicaset -n $namespace -o jsonpath='{.metadata.ownerReferences}') == "" ]]; then
      oc scale replicaset $replicaset --replicas=0 -n $namespace
    fi
  done
  for replicationcontroller in $(oc get replicationcontroller -n $namespace -o jsonpath='{.items[*].metadata.name}')
  do
    if [[ $(oc get replicationcontroller $replicationcontroller -n $namespace -o jsonpath='{.metadata.ownerReferences}') == "" ]]; then
      oc scale replicaset $replicaset --replicas=0 -n $namespace
    fi
  done
done
