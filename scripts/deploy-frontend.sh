#!/bin/bash

# Deploy script for StartTech frontend

if [ -z "$S3_BUCKET" ] || [ -z "$CLOUDFRONT_DIST_ID" ]; then
  echo "Error: S3_BUCKET and CLOUDFRONT_DIST_ID must be set."
  exit 1
fi

echo "Building frontend..."
cd ../frontend
npm run build

echo "Syncing to S3..."
aws s3 sync dist/ s3://$S3_BUCKET --delete

echo "Invalidating CloudFront cache..."
aws cloudfront create-invalidation --distribution-id $CLOUDFRONT_DIST_ID --paths "/*"

echo "Deployment complete!"
