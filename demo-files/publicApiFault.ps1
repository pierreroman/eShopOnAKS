$publicApiUrl = "public-api.agreeableplant-1c3b4609.eastus2.azurecontainerapps.io"

1..20 | ForEach-Object {
  try {
    Invoke-WebRequest -Uri "https://$publicApiUrl" -UseBasicParsing | Out-Null
    Write-Host "Request $_ succeeded" -ForegroundColor Green
  } catch {
    Write-Host "Request $_ failed: $($_.Exception.Message)" -ForegroundColor Red
  }
  Start-Sleep -Milliseconds 500
}