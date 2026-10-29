#!/usr/bin/env bash
# Creates a small AKS cluster and connects kubectl to it.
set -euo pipefail
RG=${RG:-rg-aks-start}
CLUSTER=${CLUSTER:-aks-start}
LOCATION=${LOCATION:-westeurope}

az group create --name "$RG" --location "$LOCATION"
az aks create --resource-group "$RG" --name "$CLUSTER" \
  --node-count 1 --node-vm-size Standard_B2s \
  --generate-ssh-keys
az aks get-credentials --resource-group "$RG" --name "$CLUSTER" --overwrite-existing
kubectl get nodes
