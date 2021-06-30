#!/bin/bash

# exit when any command fails
set -e

echo hello!!!
# keep track of the last executed command
#trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
#trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT

# Extract the base64 encoded config data and write this to the KUBECONFIG
echo "$KUBE_CONFIG_DATA" | base64 --decode > /tmp/config
export KUBECONFIG=/tmp/config

Configmap=$(find . -name "configmap.helm")

for configmap in $Configmap
do
    echo helm apply $configmap
    cat $configmap
    helm upgrade -f $configmap
done

rm /tmp/config
