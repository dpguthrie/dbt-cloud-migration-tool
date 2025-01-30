# dbt Cloud Migration Tool

This tool facilitates the migration of dbt Cloud resources between different instances/regions. It uses [dbtcloud-terraforming](https://github.com/dbt-labs/dbtcloud-terraforming) to export existing configurations and [terraform-provider-dbtcloud](https://github.com/dbt-labs/terraform-provider-dbtcloud) to apply them to the target instance.

## Prerequisites

- Terraform >= 1.0
- Access to both source and target dbt Cloud instances with admin privileges
- Service tokens for both source and target instances
- [dbtcloud-terraforming](https://github.com/dbt-labs/dbtcloud-terraforming) tool
- [terraform-provider-dbtcloud](https://github.com/dbt-labs/terraform-provider-dbtcloud)

## Migration Process

### 1. Install dependencies

#### Install Terraform

**Mac / Linux**
```bash
brew tap hashicorp/tap && brew install hashicorp/tap/terraform
```
**Windows**
```powershell
choco install terraform
```

#### Install `dbtcloud-terraforming`

**Mac / Linux**
```bash
brew install dbt-labs/dbt-cli/dbtcloud-terraforming
```
**Windows**

Check out the README for [dbtcloud-terraforming](https://github.com/dbt-labs/dbtcloud-terraforming) for instructions on how to install for Windows.

### 2. Export Configuration from Source Instance

First, set up environment variables for your source instance:
```bash
export DBT_CLOUD_HOST_URL="https://YOUR_SOURCE_REGION.getdbt.com/api"
export DBT_CLOUD_TOKEN="your_source_service_token"
export DBT_CLOUD_ACCOUNT_ID=your_source_account_id
```

Review and modify `resource_types.txt` to specify which resources to export. See the [dbtcloud-terraforming](https://github.com/dbt-labs/dbtcloud-terraforming) README for available resource types.

Then export the configuration:
```bash
./migrate.sh
```

Or if you haven't set environment variables, provide them as command line arguments:
```bash
./migrate.sh \
  --source-host "https://cloud.getdbt.com/api" \
  --source-token "your_source_service_token" \
  --source-account-id "your_source_account_id"
```

### 3. Review and Modify Configuration

1. Check the generated `target/resources.tf` file
   - Environment references (`deferring_environment_id`) are automatically updated to use Terraform resource references
   - Unsupported credential types are automatically set to `null`
   - A backup of the original file is saved as `resources.tf.bak`
2. Make any necessary adjustments:
   - Modify or remove `credential_id` values that were not automatically handled
   - Adjust any environment-specific settings

### 4. Apply Configuration to Target Instance

1. Set up target instance configuration:
```bash
cd target
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your target instance details
```

2. Initialize Terraform:
```bash
terraform init
```

3. Preview changes:
```bash
terraform plan
```

4. Apply changes:
```bash
terraform apply
```

5. To remove resources:
```bash
terraform destroy
```

For more advanced Terraform usage, refer to the [Terraform CLI documentation](https://www.terraform.io/cli/commands).

### 5. Post-Migration Tasks

1. **Verify Repository Connections**:
   - Reconnect Git repositories
   - Verify branch configurations
   - Test repository access

2. **Update Credentials**:
   - Add repository / warehouse credentials
   - Configure environment variables
   - Set up service account tokens

3. **Verify User Access**:
   - Ensure users have appropriate access
   - Test SSO if applicable
   - Verify group memberships

4. **Test Jobs and Environments**:
   - Run test jobs
   - Verify environment configurations
   - Check scheduler settings

## Known Limitations

1. **Credentials and Secrets**:
   - Repository credentials (SSH keys, tokens) must be manually recreated
   - Service account tokens must be regenerated
   - Environment variables containing secrets must be manually recreated

2. **Project Data**:
   - Actual project data/artifacts are not migrated
   - Job run history is not preserved
   - Job artifacts and logs are not transferred

3. **User Management**:
   - User accounts must exist in the target instance
   - User permissions must be manually verified
   - SSO configurations must be set up separately

## Usage Example

```bash
# 1. Clone this repository
git clone https://github.com/dpguthrie/dbt-cloud-migration-tool
cd dbt-cloud-migration-tool

# 2. Install dependencies
brew tap hashicorp/tap && brew install hashicorp/tap/terraform
brew install dbt-labs/dbt-cli/dbtcloud-terraforming

# 3. Set up environment variables for source instance
export DBT_CLOUD_HOST_URL="https://cloud.getdbt.com/api"
export DBT_CLOUD_TOKEN="my_service_token"
export DBT_CLOUD_ACCOUNT_ID="12345"

# 4. Export source configuration
./migrate.sh

# 5. Configure target instance
cd target
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your target instance details

# 6. Apply changes using Terraform directly
terraform init
terraform plan
terraform apply
```

## Security Considerations

1. **API Tokens**:
   - Use service account tokens with limited scope
   - Rotate tokens after migration
   - Never commit tokens to version control

2. **Sensitive Data**:
   - Manually handle all secrets and credentials
   - Use environment variables for sensitive values
   - Verify security settings in target instance

3. **Access Control**:
   - Review and verify all permission assignments
   - Implement principle of least privilege
   - Document all access changes

## Troubleshooting

### Common Issues

1. **Resource Conflicts**:
   - Ensure unique resource names in target instance
   - Check for naming conflicts before migration
   - Use resource mapping file for resolution

2. **Connection Issues**:
   - Verify API access and tokens
   - Check network connectivity
   - Confirm region endpoints

3. **Permission Errors**:
   - Verify admin access in both instances
   - Check token permissions
   - Review resource-specific access requirements

## Contributing

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md) for details on how to submit pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. 