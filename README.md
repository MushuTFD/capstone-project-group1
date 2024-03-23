
# Group 3 Project
## Our story
we want to create an app that enables users to interact with and write in anything and everything they want the world to see.

## Our vision
Our vision is to create an app that will allow users to create their own personal todo list.

## Project strategy
we make use of the different AWS applications to create our app.

![workflow](https://github.com/MushuTFD/capstone-project-group1/blob/hangy/msg-4003755471-1051147.jpg)

1. VPC - creating the network environment
2. ECS - to create the Ec2 instances cluster
3. ALB - to balance the load between the applications
4. Route53 - to manage the DNS
5. S3 Bucket - to store the static files
6. secrets manager - to do database password rotation 
7. CI/CD pipeline to the app. eg Github actions

* you can look at our website for more infomation : ```http://sctp-ce4-group1-react-1-lb-1430610283.ap-southeast-1.elb.amazonaws.com./*```


## Future improvements

1. Add security implementtion to the app. eg WAF, cloudflare
2. Add obervability to the entire app. eg Cloudwatch, X-ray

## DEVSECOPS PROJECT
### Overview
This project implements a CI/CD pipeline for provisioning and managing infrastructure using Terraform Cloud. It integrates security scanning tools and automates code formatting, validation, and infrastructure changes, ensuring secure and reliable infrastructure deployments."

## Workflow Triggers
### List the events that trigger the workflow:
- Changes to the 'main' or 'dev-snky' branches: Pushes to these branches initiate the workflow.
- Pull Requests: Opening or updating pull requests targeting the specified branches triggers the pipeline.

## Workflow Steps
### Checkout Code:
- The actions/checkout@v3 action downloads the project's code into the GitHub Actions runner environment.

### Clear Terraform Cache:
- Removes any previously cached Terraform dependencies (located in the .terraform directory) to ensure fresh downloads. This can help prevent issues caused by stale providers or modules.

### Install Snyk:
- Installs the Snyk CLI tool globally using npm for security scanning.

### Print Environment:
- Displays the AWS_REGION environment variable and any other relevant environment variables for debugging and visibility.

### Terraform Init:
- Initializes the Terraform workspace and configures the Terraform Cloud backend. Environment variables are used to set the AWS region dynamically, and secrets are used for sensitive data like AWS keys.

### Terraform fmt:
- Ensures consistent Terraform code formatting by running terraform fmt -check. The continue-on-error: true flag allows the workflow to continue even if formatting issues are found.

### Terraform Validate:
- Checks the validity of Terraform configuration files using terraform validate -no-color. Similar to formatting, using continue-on-error: true treats validation issues as warnings.

### Run Snyk auth:
- Authenticates with Snyk using a stored API token retrieved from GitHub secrets.

### Run Snyk dependency scan (pre-deployment):
- Executes snyk iac test to scan your Terraform code for vulnerabilities. The --severity-threshold=high flag ensures that only high severity vulnerabilities are reported.

### Environment Management
Production code shall be in main branch. The environment secrets shall consist of the followings:
- AWS_BUCKET_KEY_NAME
- AWS_BUCKET_NAME
- SNYK_TOKEN

Development code shall be in dev-snky branch. The environment secrets shall consist of the followings:
- AWS_BUCKET_KEY_NAME
- AWS_BUCKET_NAME
- SNYK_TOKEN

### Terraform Cloud Integration
The CICD workflow triggers Terraform Cloud runs to initiate infrastructure changes after the local checks pass.


### Revision
#### 26-Feb-2024
Jinn Liong backup the code and update the CICD workflow based on terraform cloud. It is tested and work well with terraform cloud.
1. CICD workflow consist of 2 branches ( main branch for production and dev-snky for development )
2. Environment variables will change according to main or dev-snky.
3. Add clear terraform cache at the start of the work flow for faster execution times and reduced network traffic.
4. Maintain terraform fmt and validate for faster feedback and prevent reduandant errors if problematic code execute in Terraform Cloud. The terraform validate's continue-on-error is set to true due to encounter error (Error: registry.terraform.io/hashicorp/aws: there is no package for registry.terraform.io/hashicorp/aws 5.37.0 cached in .terraform/providers).
5. Prod environment will execute in ap-southeast-1 and dev-snky environment will execute in ap-northeast-1. So that there will no need to change resource names in development and production if both environments are seperated. However IAM policy may need to implemented if encounter error in deploying infrastructures.

#### 20-Feb-2024
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

#### 15-Feb-2024
Jinn Liong add the deploy-staging.yml file. It is similar to main.yml but with difference as below.
1. Run Snyk dependency scan just after Terraform Validate.
2. Separate the code to deploy and staging stage.
3. Add AWS_ACCESS_KEY_ID_STAGING & AWS_SECRET_ACCESS_KEY_STAGING in staging stage to improve security

#### 7-Feb-2024
Jinn Liong set up a new branck (snky-dev) and added snky command after Terraform Validate.
## 6-Feb-2024
Wei Yang shared the CICD code and upload to Github