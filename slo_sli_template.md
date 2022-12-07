# API Service

﻿| Category     | SLI                                                    | SLO                                                                                                         |
|--------------|--------------------------------------------------------|-------------------------------------------------------------------------------------------------------------|
| Availability | The percentage of successful requests over the last 5m | 99%                                                                                                         |
| Latency      | 90% of requests finish in these times                  | 90% of requests below 100ms                                                                                 |
| Error Budget | The allowed downtime or the allowed failed requests percentage for the last 7 days               | Error budget is defined at 20%. This means that 20% of the requests can fail and still be within the budget |
| Throughput   | Successful requests per second                         | 5 RPS indicates the application is functioning                                                              |