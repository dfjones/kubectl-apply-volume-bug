#!/bin/bash

set -x

kubectl create namespace bad-volumes-test

kubectl apply -f ./configmap.yaml

kubectl apply -f ./configmap2.yaml

kubectl apply -f ./good.yaml

kubectl apply -f ./bad.yaml

kubectl apply -f ./good.yaml