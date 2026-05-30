# Team Contacts & SLOs

## SLOs
- frontend availability: 99.9%
- ordering-api latency p99: < 500ms
- catalog-api latency p99: < 200ms

## On-Call Rotation
- Primary: SRE Team (PagerDuty)
- Escalation: Platform Engineering

## Key Alert Thresholds
- Error rate > 5% for 5 min → P2
- Pod restart count > 3 in 10 min → P2
- Any ordering-api failure → P1