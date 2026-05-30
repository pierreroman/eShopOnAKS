# Runbook: Pod CrashLoopBackOff

## Symptoms
- Pod status shows CrashLoopBackOff in kubectl
- Alert fires from Azure Monitor

## Steps
1. kubectl get pods -n eshop
2. kubectl describe pod <pod-name> -n eshop
3. kubectl logs <pod-name> -n eshop --previous
4. Check App Insights for upstream exceptions
5. If Redis-related: verify azure-cache-for-redis is running
6. If SQL-related: verify connection strings in Key Vault

## Escalation
- Page on-call SRE if not resolved in 15 minutes