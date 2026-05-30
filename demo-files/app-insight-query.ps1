az monitor app-insights query `
  --app "appi-67txovpn4glc4" `
  --resource-group "rg-sre-agent-demo" `
  --analytics-query "requests | where timestamp > ago(15m) | summarize count() by cloud_RoleName, resultCode | order by count_ desc"