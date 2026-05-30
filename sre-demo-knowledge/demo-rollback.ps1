# ============================================
# SRE Agent Demo - Full Rollback Script
# ============================================

Write-Host "Starting rollback..." -ForegroundColor Yellow

# 1. Restore public-api to baseline config
az containerapp update `
  --name "public-api" `
  --resource-group "rg-sre-agent-demo" `
  --remove-env-vars "ASPNETCORE_ENVIRONMENT" `
  --min-replicas 1 `
  --max-replicas 10

Write-Host "✅ public-api env vars cleaned" -ForegroundColor Green

# 2. Restore web to baseline config
az containerapp update `
  --name "web" `
  --resource-group "rg-sre-agent-demo" `
  --min-replicas 1 `
  --max-replicas 10

Write-Host "✅ web restored" -ForegroundColor Green

# 3. Confirm both apps are running
az containerapp list `
  --resource-group "rg-sre-agent-demo" `
  --query "[].{Name:name, Status:properties.runningStatus, Revision:properties.latestRevisionName}" `
  -o table

Write-Host "✅ Rollback complete!" -ForegroundColor Green

# 4. Quick smoke test
$frontendUrl = "web.agreeableplant-1c3b4609.eastus2.azurecontainerapps.io"
try {
  Invoke-WebRequest -Uri "https://$frontendUrl" -UseBasicParsing | Out-Null
  Write-Host "✅ Frontend is responding" -ForegroundColor Green
} catch {
  Write-Host "❌ Frontend not responding: $($_.Exception.Message)" -ForegroundColor Red
}

# Add this line to your existing rollback script
az webapp config appsettings set --% --name "sre-agent-demo-pierrer" --resource-group "rg-sre-agent-app" --settings "INJECT_ERROR=0"
Write-Host "✅ INJECT_ERROR reset to 0" -ForegroundColor Green