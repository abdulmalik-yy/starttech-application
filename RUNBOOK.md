# Operations Runbook

This guide covers operational tasks and troubleshooting for the StartTech application.

## Troubleshooting CI/CD

### Frontend Deployment Fails
1. Check GitHub Actions logs.
2. Verify that the `S3_BUCKET` and `CLOUDFRONT_DIST_ID` secrets are set correctly.
3. If necessary, manually run: `bash scripts/deploy-frontend.sh` (ensure you have AWS CLI authenticated).

### Backend Deployment Fails
1. Check GitHub Actions logs to ensure Docker build and ECR push succeeded.
2. The deployment uses AWS Systems Manager (SSM) to trigger `deploy-backend.sh` on EC2 instances.
3. Verify that EC2 instances have the required SSM agent running and the IAM role has `AmazonSSMManagedInstanceCore` permissions.

## Application Health

### Checking Logs
All application and system logs are aggregated into CloudWatch Logs.
- Log Group: `starttech-log-group`
- Use CloudWatch Logs Insights to query application errors.

### Checking Infrastructure Status
- Use `terraform plan` from the `terraform` directory in `starttech-infra` to see if infrastructure configuration drifted.
- If Auto Scaling is failing, check the CloudWatch Alarms `high-cpu` and `low-cpu` to see if metrics are being recorded.

## Rollback Procedures

### Frontend
- To revert a frontend deployment, find the previous commit on GitHub Actions and rerun the `Frontend CI/CD` job.
- Alternatively, sync an older version of the build folder to S3.

### Backend
- Run `scripts/rollback.sh` on the EC2 instance, or deploy an older image tag using SSM.
