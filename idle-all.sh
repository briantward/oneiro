#!/bin/bash

for project in $(oc get projects -l sleep-at-night=yes -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}') 
do
  oc idle --all -n $project
done
