# StartTech Application

StartTech is a modern full-stack web application featuring a React frontend and a Golang backend, supported by MongoDB and Redis.

## Repository Structure

- `frontend/`: The React application (Vite template).
- `backend/`: The Golang API (Standard lib + Mongo + Redis).
- `scripts/`: Assorted deployment and maintenance scripts.
- `.github/workflows/`: CI/CD pipelines.

## Setup Instructions

### Prerequisites
- Node.js (v20+)
- Go (v1.22+)
- Docker (optional, for backend containerization)
- AWS CLI configured

### Local Development - Frontend
1. Navigate to the frontend directory: `cd frontend`
2. Install dependencies: `npm install`
3. Start the dev server: `npm run dev`

### Local Development - Backend
1. Navigate to the backend directory: `cd backend`
2. Set environment variables (e.g., `MONGO_URI`, `REDIS_URI`).
3. Run the application: `go run main.go`
4. The server will start on port `8080` by default.

## Deployment Guide

Deployments are entirely automated through GitHub Actions.

### Environment Secrets Needed in GitHub
To make the CI/CD pipeline work, you must add the following secrets to your GitHub repository:
- `AWS_ACCESS_KEY_ID`: AWS Access Key
- `AWS_SECRET_ACCESS_KEY`: AWS Secret Access Key
- `S3_BUCKET`: The S3 bucket name for frontend
- `CLOUDFRONT_DIST_ID`: CloudFront distribution ID for frontend invalidation
- `ECR_REPOSITORY`: Name of the ECR repository for the backend Docker images

### Pushing Code
- Any push to the `main` branch will automatically trigger both `Frontend CI/CD` and `Backend CI/CD` workflows.
- **Frontend** is built and synced to S3.
- **Backend** is tested, containerized, pushed to ECR, and deployed to EC2 instances.

For more infrastructure details, please refer to the `starttech-infra` repository and `ARCHITECTURE.md`.
