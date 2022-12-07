## Availability SLI
### The percentage of successful requests over the last 5m

sum (rate(apiserver_request_total{job="apiserver",code!~"5.."}[5m]))
/
sum (rate(apiserver_request_total{job="apiserver"}[5m]))

## Latency SLI
### 90% of requests finish in these times

histogram_quantile(0.9, sum(rate(apiserver_request_duration_seconds_bucket{job="apiserver"}[5m])) by (le, verb))


## Throughput
### Successful requests per second

sum(rate(apiserver_request_total{job="apiserver",code=~"2.."}[1s]))


## Error Budget - Remaining Error Budget
### The error budget is 20%
Remaining error budget in percentage = 1-[(1 - compliance)/(1 - objective)]

1 - ((1 - (sum(increase(apiserver_request_total{job="apiserver", code="200"}[7d])) by (verb)) / sum(increase(apiserver_request_total{job="apiserver"}[5m])) by (verb)) / (1 - 0.8))
