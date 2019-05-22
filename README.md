# kubectl apply bug

This repo demonstrates a bug with kubectl apply in the case of volumes with duplicate names.

Use `./run.sh` to run the demo. It will create a namespace `bad-volumes-test`.

Use `./clean.sh` to remove this namespace.

## The bug

`kubectl apply` allows volumes with the same `name` to be created. If the duplicate volume is then removed through a subsequent `kubectl apply`, this fails with an error.

## Details about recreating the bug

We need to create an initial good state with `kubectl apply -f ./good.yaml`.
Then the deployment is updated with `bad.yaml` which creates two volumes with the same name: `config`.
The Kube API accepts this bad deployment spec. 
Then, if we try to correct the deployment with `kubectl apply -f ./good.yaml`, the apply fails with the error:

```
The Deployment "bad-volumes-test" is invalid: spec.template.spec.containers[0].volumeMounts[0].name: Not found: "config"
```

If we start with a clean namespace and immediately apply `bad.yaml` it is properly rejected:

```
The Deployment "bad-volumes-test" is invalid: spec.template.spec.volumes[1].name: Duplicate value: "config"
```
