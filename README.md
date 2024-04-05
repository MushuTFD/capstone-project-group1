DEVSECOPS PROJECT
# Overview
This project builds a robust CI/CD pipeline for a to-do list application, hosted on AWS infrastructure provisioned using Terraform Cloud. Security is a core focus, with integrated Snyk scanning along with automatic infrastructure updates.

# Project Vision
We aim to create a user-friendly and secure to-do list application that allows users to easily manage their tasks and stay organized.

# Architecture
![workflow](https://github.com/MushuTFD/capstone-project-group1/blob/hangy/msg-4003755471-1051147.jpg)

# CI/CD Triggers
## List the events that trigger the workflow:
The CI/CD pipeline is automatically triggered by the following events:

- Pushes to the main branch (production deployment)
- Pushes to the dev-snky branch (development deployment)
- Pull requests to main or dev-snky (code review and security checks)

# Workflow Steps
## Checkout Code:
1. Checkout Code: The project's code is fetched from GitHub.
2. Clear Terraform Cache: Ensures fresh Terraform dependencies are used, preventing issues from stale data.
3. Terraform Init: Initializes the Terraform workspace and sets up the Terraform Cloud backend for remote state management. Configuration is dynamically adjusted based on the target environment (dev or prod).
4. Terraform fmt: Enforces consistent code formatting.
5. Terraform Validate: Validates the syntax and structure of Terraform configurations.
6. Snyk Installation (If needed): Installs the Snyk CLI for security scanning.
7. Snyk IaC Scanning: Terraform code for potential infrastructure security vulnerabilities.
8. Snyk SAST Scanning : Analyzes application code to find security flaws and weaknesses.
9. Snyk SCA Scanning (Open Source Test and Monitor): Checks for known vulnerabilities in your project's open-source dependencies and sets up continuous monitoring.
10. Environment-Specific Deployment via Terraform Cloud

## Security Considerations
- Snyk IaC Scanning: Proactively identifies potential security misconfigurations in infrastructure-as-code.
- Snyk SAST Scanning:  Analyzes application code to find vulnerabilities. 
- Snyk SCA Scanning: Detects known vulnerabilities in open-source dependencies and sets up continuous monitoring.
- Environment Separation: Reduces the risk of accidental changes to production by isolating development environments.
- Secrets Management: Sensitive credentials are stored securely in GitHub secrets.

## Environment Management:
- main branch: Represents the production environment, with resources deployed typically in the ap-southeast-1 AWS region.
- dev-snky branch: Represents the development environment, with resources deployed typically in the ap-northeast-1 AWS region.

## Environment Secrets:
Each environment requires the following secrets stored in GitHub:

- AWS_BUCKET_KEY_NAME
- AWS_BUCKET_NAME
- SNYK_TOKEN

## Terraform Cloud Integration:
Successful completion of local checks in the CI/CD workflow triggers Terraform Cloud runs to apply infrastructure changes.

# Future Improvements
- Enhanced Security: Implement WAF, Cloudflare, etc.
- Observability: Integrate CloudWatch, X-ray, and other monitoring tools.

# Revision
## 13-Mar-2024
Jinn Liong update README.md

## 10-Mar-2024
Jinn Liong added snyk SAST scan and Snyk Open Source Scan and Monitor into snykcheck.yml. Currently the application is developing, the CICD work flow will not stop even snyk scan detects issues. Once the applications are ready, the 3 "|| true" st the snyk scan needs to remove

## 7-Mar-2024
Wei Yang splits main.yml into main_dev.yml, main_prod.yml and snykcheck.yml

## 26-Feb-2024
Jinn Liong backup the code and update the CICD workflow based on terraform cloud. It is tested and work well with terraform cloud.
1. CICD workflow consist of 2 branches ( main branch for production and dev-snky for development )
2. Environment variables will change according to main or dev-snky.
3. Add clear terraform cache at the start of the work flow for faster execution times and reduced network traffic.
4. Maintain terraform fmt and validate for faster feedback and prevent reduandant errors if problematic code execute in Terraform Cloud. The terraform validate's continue-on-error is set to true due to encounter error (Error: registry.terraform.io/hashicorp/aws: there is no package for registry.terraform.io/hashicorp/aws 5.37.0 cached in .terraform/providers).
5. Prod environment will execute in ap-southeast-1 and dev-snky environment will execute in ap-northeast-1. So that there will no need to change resource names in development and production if both environments are seperated. However IAM policy may need to implemented if encounter error in deploying infrastructures.

## 20-Feb-2024
Jinn Liong modify removed the original main.yml and rename deploy-staging.yml to main.yml with the modification as below
1. Add SNYK_TOKEN. Everyone should log in to app.snyk.io to get the API Token and add in to the Github Secret Variable.
2. AWS_ACCESS_KEY_ID_STAGING & AWS_SECRET_ACCESS_KEY_STAGING are same as AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY for testing purpose.
3. Mask off "- uses: actions/github-script@v6 cmd" and related commands
4. Mask off "needs: [build, dependency-scan, unit-tests] # Ensure previous jobs succeed"
5. Replacing the existing Terraform Apply to:

```sh
- name: Terraform Apply
        if: github.ref == 'refs/heads/"main"' && github.event_name == 'push'
        run: terraform apply -auto-approve -input=false 
```
Terraform-Validate-Plan, Deployment and Staging and SNKY cmd can run successfully on 20 Feb-24.

## 15-Feb-2024
Jinn Liong add the deploy-staging.yml file. It is similar to main.yml but with difference as below.
1. Run Snyk dependency scan just after Terraform Validate.
2. Separate the code to deploy and staging stage.
3. Add AWS_ACCESS_KEY_ID_STAGING & AWS_SECRET_ACCESS_KEY_STAGING in staging stage to improve security

## 7-Feb-2024
Jinn Liong set up a new branck (snky-dev) and added snky command after Terraform Validate.
## 6-Feb-2024
Wei Yang shared the CICD code and upload to Github