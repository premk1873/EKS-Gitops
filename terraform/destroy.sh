#!/usr/bin/env bash
set -e

echo "=== Step 1: Deleting all LoadBalancer-type Services (prevents orphaned ELBs) ==="
kubectl get svc --all-namespaces -o json | \
  jq -r '.items[] | select(.spec.type=="LoadBalancer") | "\(.metadata.namespace) \(.metadata.name)"' | \
  while read -r ns name; do
    echo "Deleting svc/$name in namespace $ns..."
    kubectl delete svc "$name" -n "$ns" --wait=true --timeout=60s || true
  done

echo "=== Step 2: Waiting 30s for AWS to actually deprovision the ELBs ==="
sleep 30

echo "=== Step 3: Verifying no leftover ELBs remain ==="
aws elbv2 describe-load-balancers --region us-east-1 --query 'LoadBalancers[].LoadBalancerName' --output text
aws elb describe-load-balancers --region us-east-1 --query 'LoadBalancerDescriptions[].LoadBalancerName' --output text

echo "=== Step 4: Running terraform destroy ==="
cd "$(dirname "$0")"
terraform destroy -auto-approve