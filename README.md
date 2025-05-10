# Terraform Modules with Remote State Management in S3 and DynamoDB

This project provides a structured and reusable approach to managing Terraform infrastructure using modules and remote state management. The remote backend is configured with Amazon S3 for storing the Terraform state file and DynamoDB for state locking to avoid race conditions during concurrent operations.

## Overview

- Modular Terraform codebase for scalable infrastructure
- Centralized remote backend using AWS S3
- State locking and consistency using DynamoDB
- Environment-based separation (dev, staging, prod)
- Easy integration into CI/CD pipelines

## Features

- Reusable Terraform modules for common AWS resources
- Backend configuration with `terraform init` for remote state
- Secure and versioned state storage using S3
- Locking and consistency control via DynamoDB
- Support for workspaces or separate backend files per environment

## Tools and Technologies

- Terraform
- AWS S3 (for state storage)
- AWS DynamoDB (for state locking)
- AWS CLI
- IAM (for securing access to state)

## Backend Setup

1. **Create S3 Bucket**  
   Create a versioned S3 bucket to store the state files.

2. **Create DynamoDB Table**  
   Create a DynamoDB table with `LockID` as the primary key for state locking.

3. **Backend Configuration**  
   Configure the `backend` block in your Terraform code:

   ```hcl
   terraform {
     backend "s3" {
       bucket         = "your-terraform-state-bucket"
       key            = "env/terraform.tfstate"
       region         = "us-east-1"
       dynamodb_table = "your-lock-table"
       encrypt        = true
     }
   }
