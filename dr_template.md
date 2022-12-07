# Infrastructure

## AWS Zones
**Zone 1**: us-east-2 <br>
**Zone 2**: us-west-1

## Servers and Clusters

### Table 1.1 Summary
﻿| Asset              | Purpose                                                                                 | Size                           | Qty                                       | DR                                    |
|--------------------|-----------------------------------------------------------------------------------------|--------------------------------|-------------------------------------------|---------------------------------------|
| VM or EC2 instance | A virtual machine to host the application                                               | t3.micro                       | 3                                         | Deployed to DR zone or secondary zone |
| EKS Cluster        | A managed kubernetes cluster which has the monitoring stack                             | worker nodes size is t3.medium | 2 (desired size with auto-scaling policy) | Deployed to DR zone or secondary zone |
| VPC                | A private data center in AWS                                                            | -                              | 1                                         | Deployed to DR zone or secondary zone |
| ALB                | Application Load Balancer which used to load balance the traffic to different instances | -                              | 1                                         | Deployed to DR zone or secondary zone |
| SSH Key            | An private key used to SSH to the instances                                             | -                              | 1                                         | Used the same key across both zones   |
| SQL Cluster        | A SQL Cluster (Aurora)                                                                  | db.t2.small (instance)         | 2 instances per cluster                   | Deployed to DR zone or secondary zone |

### Descriptions
- **VM or EC2 instance**: A virtual machine to host the application
- **EKS Cluster**: A managed kubernetes cluster which has the monitoring stack installed with blackbox
- **VPC**: A virtual private cloud or simply a private data center in an AWS region
- **ALB**: An application load balancer which is used to load balance the traffic between different VMs
- **SSH Key**: A private key which is used to SSH to the VMs
- **SQL Cluster**: A SQL Cluster (Aurora) which has geo-replication or automatic failover by default

## DR Plan
### Pre-Steps:

You should deploy all resources in the zone 2 using the Terraform Code (VM Cluster, EKS, ALB, VPC, SQL Cluster)

## Steps:

You would setup the DNS to point normal to the ALB in Zone 1 and the VIP of the SQL Cluster would point to the primary cluster in Zone 1 as well (application and database).

In case of a disaster, you should update the DNS to point to the ALB in Zone 2 and the VIP of the SQL Cluster would detect the cluster is not available and begin the failover automatically.

You could use the DNS (Route 53) with failover routing, so no need to manually update the DNS in case of regional disaster in Zone 1.