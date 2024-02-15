DEVSECOPS PROJECT

# Revision
## _15-Feb-2024
Jinn Liong add the deploy-staging.yml file. It is similar to main.yml but with difference as below.
1. Run Snyk dependency scan just after Terraform Validate.
2. Separate the code to deploy and staging stage.
3. Add AWS_ACCESS_KEY_ID_STAGING & AWS_SECRET_ACCESS_KEY_STAGING in staging stage to improve security

## _7-Feb-2024
Jinn Liong set up a new branck (snky-dev) and added snky command after Terraform Validate.
## _6-Feb-2024
Wei Yang shared the CICD code and upload to Github