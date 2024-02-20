DEVSECOPS PROJECT

# Revision
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