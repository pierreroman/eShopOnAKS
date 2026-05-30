$webUrl = "web.agreeableplant-1c3b4609.eastus2.azurecontainerapps.io"

$protectedEndpoints = @(
  "/Order/MyOrders",
  "/Order/Detail/1",
  "/Order/Detail/42",
  "/Manage/MyAccount",
  "/Manage/ChangePassword",
  "/Manage/TwoFactorAuthentication",
  "/Manage/ExternalLogins",
  "/User/GetCurrentUser"
)

Write-Host "Generating unauthenticated request spike..." -ForegroundColor Yellow

1..50 | ForEach-Object {
  $endpoint = $protectedEndpoints[($_ - 1) % $protectedEndpoints.Count]
  $uri = "https://$webUrl$endpoint"
  try {
    $response = Invoke-WebRequest -Uri $uri -UseBasicParsing -MaximumRedirection 0 -ErrorAction Stop
    Write-Host "Request $_ -> $endpoint : $($response.StatusCode)" -ForegroundColor Green
  } catch {
    $statusCode = $_.Exception.Response.StatusCode.value__
    Write-Host "Request $_ -> $endpoint : $statusCode" -ForegroundColor Red
  }
  Start-Sleep -Milliseconds 300
}

Write-Host "Spike complete!" -ForegroundColor Yellow