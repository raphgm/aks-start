# AKS Start

A SKILL.SCH lab: create an Azure Kubernetes Service (AKS) cluster, deploy a web app to it, expose it to the internet, then clean up.

## Prerequisites

- Azure subscription and Azure CLI (`az login`)
- kubectl (`az aks install-cli`)

## 1. Create the cluster

```bash
./create-cluster.sh
```

This creates resource group `rg-aks-start` and a one-node cluster (`Standard_B2s`), then points kubectl at it. Override with `RG=... CLUSTER=... LOCATION=... ./create-cluster.sh`.

## 2. Deploy

```bash
kubectl apply -f k8s/
kubectl get pods -l app=hello-aks
```

`k8s/deployment.yaml` runs two nginx replicas with resource limits and a readiness probe. `k8s/service.yaml` puts an Azure load balancer in front of them.

## 3. Reach it

```bash
kubectl get service hello-aks --watch
```

When `EXTERNAL-IP` changes from `<pending>` to an address, open `http://<EXTERNAL-IP>`.

## 4. Scale and observe

```bash
kubectl scale deployment hello-aks --replicas=4
kubectl get pods -o wide
kubectl describe service hello-aks
```

## 5. Clean up (stops billing)

```bash
az group delete --name rg-aks-start --yes --no-wait
```
