# Deploy-Web-3-Tier-Terraform
## AWS 3-Tier Architecture

This project is deployed on AWS using a classic 3-tier pattern across two Availability Zones (AZs) for high availability and fault tolerance.

### 1. Presentation Tier
- **Public Subnets**  
- Amazon Route 53 for DNS resolution  
- Amazon CloudFront for global CDN, SSL/TLS termination (via ACM)  
- Application Load Balancer (ALB) routing HTTPS traffic to  
- NGINX servers serving a React single-page application  

### 2. Application Tier
- **Private Subnets** (in AZ A & AZ B)  
- ALB forwards requests from the presentation tier to  
- Node.js application servers managed by PM2  
- Bastion host (in a public subnet) for secure SSH access  

### 3. Data Tier
- **Private Subnets** (in AZ A & AZ B)  
- Amazon RDS for MySQL in Multi-AZ configuration:  
  - Primary instance in AZ A  
  - Standby replica in AZ B  
- Automatic failover, data redundancy and encryption at rest  

### Networking & Security
- Public subnets house only the web tier and bastion host  
- Private subnets isolate application and database servers  
- Security groups lock down traffic between tiers  
- Resources span two AZs to eliminate single points of failure  
