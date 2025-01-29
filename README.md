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

- Install Terraform

**Mac / Linux**
```bash
brew tap hashicorp/tap && brew install hashicorp/tap/terraform
```
**Windows**
```powershell
choco install terraform
```

- Install `dbtcloud-terraforming`

**Mac / Linux**
```bash
brew install dbt-labs/dbt-cli/dbtcloud-terraforming
```
**Windows**
Check out the README for [dbtcloud-terraforming](https://github.com/dbt-labs/dbtcloud-terraforming) for instructions on how to install for Windows.

### 2. Export Configuration from Source Instance

```bash
# Set up environment variables for source instance
export DBT_CLOUD_HOST="https://YOUR_SOURCE_REGION.getdbt.com/api"
export DBT_CLOUD_TOKEN="your_source_service_token"
export DBT_CLOUD_ACCOUNT_ID=your_source_account_id
```

Verify the things to export in `resource_types.txt`.  It's currently set to export as much as possible, so if you're only using Snowflake, you can remove the resources relevant to Bigquery, Databricks, etc.  See the [dbtcloud-terraforming](https://github.com/dbt-labs/dbtcloud-terraforming) README for more details.

```bash  
# Export configuration using dbtcloud-terraforming
./migrate.sh export
```

Or if you haven't set up the environment variables yet, you can use the arguments:

```bash
./migrate.sh export \
  --source-host "https://cloud.getdbt.com/api" \
  --source-token "your_source_service_token" \
  --source-account-id "your_source_account_id"
```

Take a look at the resulting `resources.tf` file and make sure it looks good.  If you need to make changes, you can do so in the `resources.tf` file.

- Look for `deferring_environment_id` and replace it with the `environment_id` of the environment you want to defer to.  Should look something like `dbtcloud_environment.terraform_managed_resource_<id>.environment_id`.  **Also, be aware that you'll need to have at least one run in that deferred environment before this can work properly.  I recommend running a `dbt parse` or `dbt compile`.
- Look for `credential_id` and replace it with the `credential_id` of the credential you want to use or just set to `null`

### 3. Apply Configuration to Target Instance

Modify the [`target/terraform.tfvars.example`](target/terraform.tfvars.example) file with the correct values for the target instance and rename it to `terraform.tfvars`.

Plan the changes:
```bash
./migrate.sh plan
```

Apply the changes:
```bash
./migrate.sh apply
```

### 4. Post-Migration Tasks

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

## Usage Example

```bash
# 1. Clone this repository
git clone https://github.com/dpguthrie/dbt-cloud-migration-tool
cd dbt-cloud-migration-tool

# 2. Install dependencies
brew tap hashicorp/tap && brew install hashicorp/tap/terraform
brew install dbt-labs/dbt-cli/dbtcloud-terraforming

# Set up environment variables for source instance
export DBT_CLOUD_HOST="https://cloud.getdbt.com/api"
export DBT_CLOUD_TOKEN="my_service_token"
export DBT_CLOUD_ACCOUNT_ID="12345"

# 3. Export source configuration
./migrate.sh export

# 4. Plan and apply changes
./migrate.sh plan
./migrate.sh apply
```

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