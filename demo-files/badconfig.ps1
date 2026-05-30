# Inject a bad connection string to trigger real DB exceptions
az containerapp update `
  --name "public-api" `
  --resource-group "rg-sre-agent-demo" `
  --set-env-vars "ConnectionStrings__CatalogConnection=Server=fake-server;Database=fake-db;User Id=fake;Password=fake;"

Write-Host "✅ Bad connection string injected" -ForegroundColor Yellow



1..20 | ForEach-Object {
  try {
    Invoke-WebRequest -Uri "https://$publicApiUrl/" -UseBasicParsing | Out-Null
    Write-Host "Request $_ succeeded" -ForegroundColor Green
  } catch {
    Write-Host "Request $_ failed: $($_.Exception.Response.StatusCode.value__)" -ForegroundColor Red
  }
  Start-Sleep -Milliseconds 300
}
