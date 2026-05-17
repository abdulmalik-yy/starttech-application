# System Architecture

The StartTech application is a scalable full-stack application deployed on AWS.

## Components

### Frontend (React)
- Hosted statically in an **S3 Bucket**.
- Served globally using **CloudFront** (CDN).
- CI/CD managed via GitHub Actions which syncs the built assets to S3 and invalidates CloudFront.

### Backend (Golang)
- Deployed on **EC2 instances** running inside an **Auto Scaling Group (ASG)**.
- Scalability is managed via CloudWatch alarms tracking `CPUUtilization` (scales up at >80%, scales down at <20%).
- Traffic is routed to EC2 instances using an **Application Load Balancer (ALB)**.

### Caching & Sessions (Redis)
- Powered by an **ElastiCache Redis cluster** hosted in private subnets.
- Ensures high-speed caching of frequent requests and session data.

### Database (MongoDB)
- Data persistence is handled via **MongoDB Atlas** (or a self-hosted MongoDB instance, based on environment configuration).
- The Go backend connects to MongoDB using a standard URI provided via environment variables (`MONGO_URI`).

## Infrastructure Management
- All cloud resources are provisioned using **Terraform**.
- The `starttech-infra` repository contains modules for `networking`, `compute`, `storage`, and `monitoring`.
- Secrets for CI/CD and production are managed securely.
