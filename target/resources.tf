resource "dbtcloud_global_connection" "terraform_managed_resource_149792" {
  name = "Snowflake - Main"
  snowflake = {
    account                   = "zna84829"
    allow_sso                 = false
    client_session_keep_alive = false
    database                  = "DOUG_DEMO_V2"
    oauth_client_id           = "---TBD---"
    oauth_client_secret       = "---TBD---"
    warehouse                 = "TRANSFORMING"
  }
}

resource "dbtcloud_global_connection" "terraform_managed_resource_103654" {
  databricks = {
    catalog   = "dpg_dev"
    host      = "dbc-c7c89cba-cf9b.cloud.databricks.com"
    http_path = "/sql/1.0/warehouses/ccb213f868b17d14"
  }
  name = "Databricks"
}

resource "dbtcloud_group" "terraform_managed_resource_643060" {
  assign_by_default = false
  name              = "Read Only "
  group_permissions {
    all_projects   = true
    permission_set = "readonly"
  }
}

resource "dbtcloud_group" "terraform_managed_resource_782589" {
  assign_by_default = false
  name              = "External Developers"
  group_permissions {
    all_projects                    = false
    permission_set                  = "developer"
    project_id                      = dbtcloud_project.terraform_managed_resource_385562.id
    writable_environment_categories = ["all"]
  }
}

resource "dbtcloud_service_token" "terraform_managed_resource_18115" {
  name  = "Semantic Layer Token"
  state = 1
  service_token_permissions {
    all_projects   = false
    permission_set = "semantic_layer_only"
    project_id     = dbtcloud_project.terraform_managed_resource_270542.id
  }
  service_token_permissions {
    all_projects   = false
    permission_set = "metadata_only"
    project_id     = dbtcloud_project.terraform_managed_resource_270542.id
  }
}

resource "dbtcloud_service_token" "terraform_managed_resource_20819" {
  name  = "Everything"
  state = 1
  service_token_permissions {
    all_projects   = true
    permission_set = "account_admin"
  }
  service_token_permissions {
    all_projects   = true
    permission_set = "semantic_layer_only"
  }
  service_token_permissions {
    all_projects   = true
    permission_set = "metadata_only"
  }
  service_token_permissions {
    all_projects   = true
    permission_set = "job_admin"
  }
  service_token_permissions {
    all_projects                    = true
    permission_set                  = "developer"
    writable_environment_categories = ["all"]
  }
  service_token_permissions {
    all_projects   = true
    permission_set = "project_creator"
  }
}

resource "dbtcloud_service_token" "terraform_managed_resource_21930" {
  name  = "Disco API Error Repro"
  state = 1
  service_token_permissions {
    all_projects   = true
    permission_set = "metadata_only"
  }
  service_token_permissions {
    all_projects   = true
    permission_set = "semantic_layer_only"
  }
}

resource "dbtcloud_service_token" "terraform_managed_resource_33238" {
  name  = "Account Viewer"
  state = 1
  service_token_permissions {
    all_projects   = true
    permission_set = "account_viewer"
  }
}

resource "dbtcloud_service_token" "terraform_managed_resource_33371" {
  name  = "Fivetran"
  state = 1
  service_token_permissions {
    all_projects                    = true
    permission_set                  = "developer"
    writable_environment_categories = ["all"]
  }
}

resource "dbtcloud_service_token" "terraform_managed_resource_40888" {
  name  = "Account Admin SL Test"
  state = 1
  service_token_permissions {
    all_projects   = true
    permission_set = "account_admin"
  }
}

resource "dbtcloud_service_token" "terraform_managed_resource_49544" {
  name  = "Sigma - Account Viewer Only"
  state = 1
  service_token_permissions {
    all_projects   = true
    permission_set = "account_viewer"
  }
}

resource "dbtcloud_webhook" "terraform_managed_resource_wsu_2nnAtgRV1jQvN4VMLwqjMAwzgWC" {
  active      = true
  client_url  = "https://not-a-real-url.com"
  event_types = ["job.run.started"]
  name        = "Updating webhook"
}

resource "dbtcloud_webhook" "terraform_managed_resource_wsu_2moE8ZImMIny7JlWkKnpPqgANc4" {
  active      = false
  client_url  = "https://dpguthrie--dbt-cloud-webhook-datadog-webhook-handler-dev.modal.run/"
  event_types = ["job.run.completed"]
  name        = "Modal Test"
}

resource "dbtcloud_webhook" "terraform_managed_resource_wsu_2kheTjIOlT0i0WF5aiaEzHwWT56" {
  active      = true
  client_url  = "https://transformation-partners.fivetran.com/v1/partner-webhooks/dbt-cloud"
  description = "Webhook subscription providing Fivetran with the dbt Cloud account jobs updates"
  event_types = ["job.run.started", "job.run.completed"]
  job_ids = [
    dbtcloud_job.terraform_managed_resource_384676.id,
  ]
  name = "Fivetran webhook subscription"
}

resource "dbtcloud_webhook" "terraform_managed_resource_wsu_2jQlghO0ZupFa8F3nMq8e46ksDQ" {
  active      = true
  client_url  = "https://hello-world.com"
  description = "Webhook for all job events"
  event_types = ["job.run.started", "job.run.completed", "job.run.errored"]
  name        = "My Cool Webhook"
}

resource "dbtcloud_environment" "terraform_managed_resource_105440" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  dbt_version                = "latest"
  enable_model_query_history = false
  name                       = "Development"
  project_id                 = dbtcloud_project.terraform_managed_resource_131414.id
  type                       = "development"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_105441" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  credential_id              = dbtcloud_snowflake_credential.terraform_managed_resource_144378.credential_id
  custom_branch              = "prod-0.22.0"
  dbt_version                = "latest"
  deployment_type            = "production"
  enable_model_query_history = true
  name                       = "Production"
  project_id                 = dbtcloud_project.terraform_managed_resource_131414.id
  type                       = "deployment"
  use_custom_branch          = true
}

resource "dbtcloud_environment" "terraform_managed_resource_117106" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  dbt_version                = "latest"
  enable_model_query_history = false
  name                       = "Development"
  project_id                 = dbtcloud_project.terraform_managed_resource_146088.id
  type                       = "development"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_117108" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  credential_id              = dbtcloud_snowflake_credential.terraform_managed_resource_157658.credential_id
  dbt_version                = "latest"
  enable_model_query_history = false
  name                       = "Prod"
  project_id                 = dbtcloud_project.terraform_managed_resource_146088.id
  type                       = "deployment"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_145477" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_103654.id
  dbt_version                = "latest"
  enable_model_query_history = false
  name                       = "Development"
  project_id                 = dbtcloud_project.terraform_managed_resource_189133.id
  type                       = "development"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_172249" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_103654.id
  credential_id              = null
  dbt_version                = "latest"
  deployment_type            = "production"
  enable_model_query_history = false
  name                       = "Production"
  project_id                 = dbtcloud_project.terraform_managed_resource_189133.id
  type                       = "deployment"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_210259" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_103654.id
  credential_id              = null
  dbt_version                = "latest"
  enable_model_query_history = false
  name                       = "CI"
  project_id                 = dbtcloud_project.terraform_managed_resource_189133.id
  type                       = "deployment"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_218761" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  dbt_version                = "latest"
  enable_model_query_history = false
  name                       = "Development"
  project_id                 = dbtcloud_project.terraform_managed_resource_270542.id
  type                       = "development"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_218762" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  credential_id              = dbtcloud_snowflake_credential.terraform_managed_resource_279952.credential_id
  dbt_version                = "latest"
  deployment_type            = "production"
  enable_model_query_history = true
  name                       = "Production"
  project_id                 = dbtcloud_project.terraform_managed_resource_270542.id
  type                       = "deployment"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_265924" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  credential_id              = dbtcloud_snowflake_credential.terraform_managed_resource_334614.credential_id
  dbt_version                = "latest"
  enable_model_query_history = false
  name                       = "CI"
  project_id                 = dbtcloud_project.terraform_managed_resource_131414.id
  type                       = "deployment"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_279167" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  dbt_version                = "latest"
  enable_model_query_history = false
  name                       = "Development"
  project_id                 = dbtcloud_project.terraform_managed_resource_334748.id
  type                       = "development"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_281984" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  dbt_version                = "latest"
  enable_model_query_history = false
  name                       = "Development"
  project_id                 = dbtcloud_project.terraform_managed_resource_338153.id
  type                       = "development"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_282002" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  credential_id              = dbtcloud_snowflake_credential.terraform_managed_resource_352995.credential_id
  dbt_version                = "latest"
  enable_model_query_history = false
  name                       = "CI"
  project_id                 = dbtcloud_project.terraform_managed_resource_338153.id
  type                       = "deployment"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_282003" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  credential_id              = dbtcloud_snowflake_credential.terraform_managed_resource_352996.credential_id
  dbt_version                = "latest"
  deployment_type            = "production"
  enable_model_query_history = true
  name                       = "Production"
  project_id                 = dbtcloud_project.terraform_managed_resource_338153.id
  type                       = "deployment"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_282304" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  credential_id              = dbtcloud_snowflake_credential.terraform_managed_resource_353367.credential_id
  dbt_version                = "latest"
  enable_model_query_history = false
  name                       = "CI"
  project_id                 = dbtcloud_project.terraform_managed_resource_334748.id
  type                       = "deployment"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_282305" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  credential_id              = dbtcloud_snowflake_credential.terraform_managed_resource_353368.credential_id
  dbt_version                = "latest"
  deployment_type            = "production"
  enable_model_query_history = true
  name                       = "Production"
  project_id                 = dbtcloud_project.terraform_managed_resource_334748.id
  type                       = "deployment"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_288697" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  dbt_version                = "latest"
  enable_model_query_history = false
  name                       = "Development"
  project_id                 = dbtcloud_project.terraform_managed_resource_345530.id
  type                       = "development"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_288698" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  credential_id              = dbtcloud_snowflake_credential.terraform_managed_resource_360698.credential_id
  dbt_version                = "latest"
  deployment_type            = "production"
  enable_model_query_history = true
  name                       = "Production"
  project_id                 = dbtcloud_project.terraform_managed_resource_345530.id
  type                       = "deployment"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_288699" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  credential_id              = dbtcloud_snowflake_credential.terraform_managed_resource_360699.credential_id
  dbt_version                = "latest"
  enable_model_query_history = false
  name                       = "CI"
  project_id                 = dbtcloud_project.terraform_managed_resource_345530.id
  type                       = "deployment"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_308743" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  credential_id              = dbtcloud_snowflake_credential.terraform_managed_resource_384630.credential_id
  custom_branch              = "qa"
  dbt_version                = "latest"
  deployment_type            = "staging"
  enable_model_query_history = false
  name                       = "Staging"
  project_id                 = dbtcloud_project.terraform_managed_resource_270542.id
  type                       = "deployment"
  use_custom_branch          = true
}

resource "dbtcloud_environment" "terraform_managed_resource_308752" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  credential_id              = dbtcloud_snowflake_credential.terraform_managed_resource_384641.credential_id
  dbt_version                = "latest"
  enable_model_query_history = false
  name                       = "CI"
  project_id                 = dbtcloud_project.terraform_managed_resource_270542.id
  type                       = "deployment"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_338842" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  dbt_version                = "latest"
  enable_model_query_history = false
  name                       = "Development"
  project_id                 = dbtcloud_project.terraform_managed_resource_385562.id
  type                       = "development"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_339105" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  credential_id              = dbtcloud_snowflake_credential.terraform_managed_resource_428348.credential_id
  dbt_version                = "latest"
  deployment_type            = "production"
  enable_model_query_history = false
  name                       = "Production"
  project_id                 = dbtcloud_project.terraform_managed_resource_385562.id
  type                       = "deployment"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_339531" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  credential_id              = dbtcloud_snowflake_credential.terraform_managed_resource_428981.credential_id
  dbt_version                = "latest"
  enable_model_query_history = false
  name                       = "CI"
  project_id                 = dbtcloud_project.terraform_managed_resource_385562.id
  type                       = "deployment"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_341021" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  dbt_version                = "latest"
  enable_model_query_history = false
  name                       = "Development"
  project_id                 = dbtcloud_project.terraform_managed_resource_386635.id
  type                       = "development"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_341022" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  credential_id              = dbtcloud_snowflake_credential.terraform_managed_resource_431310.credential_id
  dbt_version                = "latest"
  deployment_type            = "production"
  enable_model_query_history = false
  name                       = "Production"
  project_id                 = dbtcloud_project.terraform_managed_resource_386635.id
  type                       = "deployment"
  use_custom_branch          = false
}

resource "dbtcloud_environment" "terraform_managed_resource_341370" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  credential_id              = dbtcloud_snowflake_credential.terraform_managed_resource_431814.credential_id
  custom_branch              = "qa"
  dbt_version                = "latest"
  enable_model_query_history = false
  name                       = "QA"
  project_id                 = dbtcloud_project.terraform_managed_resource_385562.id
  type                       = "deployment"
  use_custom_branch          = true
}

resource "dbtcloud_environment" "terraform_managed_resource_344437" {
  connection_id              = dbtcloud_global_connection.terraform_managed_resource_149792.id
  dbt_version                = "latest"
  enable_model_query_history = false
  name                       = "Development"
  project_id                 = dbtcloud_project.terraform_managed_resource_390352.id
  type                       = "development"
  use_custom_branch          = false
}

resource "dbtcloud_environment_variable" "terraform_managed_resource_189133_DBT_MESH_DBRX_SCHEMA_EXTERNAL_MANAGED" {
  environment_values = {
    CI          = "my_managed_schema"
    Development = "my_managed_schema"
    Production  = "my_managed_schema_prod"
    project     = "my_managed_schema"
  }
  name       = "DBT_MESH_DBRX_SCHEMA_EXTERNAL_MANAGED"
  project_id = dbtcloud_project.terraform_managed_resource_189133.id
  depends_on = [
    dbtcloud_environment.terraform_managed_resource_145477,
    dbtcloud_environment.terraform_managed_resource_172249,
    dbtcloud_environment.terraform_managed_resource_210259,
  ]
}

resource "dbtcloud_environment_variable" "terraform_managed_resource_270542_DBT_TARGET_ENV" {
  environment_values = {
    CI          = "ci"
    Development = "dev"
    Production  = "prod"
    Staging     = "staging"
    project     = "dev"
  }
  name       = "DBT_TARGET_ENV"
  project_id = dbtcloud_project.terraform_managed_resource_270542.id
  depends_on = [
    dbtcloud_environment.terraform_managed_resource_218761,
    dbtcloud_environment.terraform_managed_resource_218762,
    dbtcloud_environment.terraform_managed_resource_308743,
    dbtcloud_environment.terraform_managed_resource_308752,
  ]
}

resource "dbtcloud_environment_variable" "terraform_managed_resource_270542_DBT_EXPERIMENTAL_MICROBATCH" {
  environment_values = {
    CI          = "True"
    Development = "True"
    Production  = "True"
    Staging     = "True"
    project     = "True"
  }
  name       = "DBT_EXPERIMENTAL_MICROBATCH"
  project_id = dbtcloud_project.terraform_managed_resource_270542.id
  depends_on = [
    dbtcloud_environment.terraform_managed_resource_218761,
    dbtcloud_environment.terraform_managed_resource_218762,
    dbtcloud_environment.terraform_managed_resource_308743,
    dbtcloud_environment.terraform_managed_resource_308752,
  ]
}

resource "dbtcloud_job" "terraform_managed_resource_106100" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_105441.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt build"]
  generate_docs          = true
  name                   = "Production"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_131414.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_hours         = [0]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = true
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_106109" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_265924.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt build --select state:modified+"]
  generate_docs          = false
  name                   = "CI"
  num_threads            = 8
  project_id             = dbtcloud_project.terraform_managed_resource_131414.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_121820" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_117108.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt build -s bad_model"]
  generate_docs          = false
  name                   = "Test 1 - Build Bad Model"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_146088.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_121821" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_117108.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt build -s good_model"]
  generate_docs          = false
  name                   = "Test 2 - Build Good Model, Bad Test"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_146088.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_121822" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_117108.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt build -s bad_model", "dbt run-operation bad_macro"]
  generate_docs          = false
  name                   = "Test 3 - Build Bad Model, Run Operation"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_146088.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_121823" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_117108.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt run -s good_model", "dbt run-operation bad_macro"]
  generate_docs          = false
  name                   = "Test 4 - Build Good Model, Bad Macro"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_146088.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_121824" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_117108.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt run-operation good_macro", "dbt build -s bad_model", "dbt run-operation bad_macro"]
  generate_docs          = false
  name                   = "Test 5 - Good Macro, Bad Model, Bad Macro"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_146088.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_121825" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_117108.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt run -s bad_model"]
  generate_docs          = false
  name                   = "Test 6 - Run Bad Model"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_146088.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_121826" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_117108.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt test -s good_model"]
  generate_docs          = false
  name                   = "Test 7 - Bad Test"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_146088.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_121830" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_117108.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt seed"]
  generate_docs          = false
  name                   = "Test 8 - Bad Seed"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_146088.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_121832" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_117108.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt snapshot"]
  generate_docs          = false
  name                   = "Test 9 - Bad Snapshot"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_146088.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_121839" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_117108.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt run"]
  generate_docs          = false
  name                   = "Normal Prod Run"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_146088.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_122458" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_117108.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt run -s good_model bad_model --vars '{\"key\": \"value\"}'"]
  generate_docs          = false
  name                   = "Test 10 - Restart with Vars"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_146088.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_122473" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_117108.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt build -s stg_tpch_orders", "dbt run -s good_model", "dbt build -s good_model --vars '{key: value, other_key: other_value}'", "dbt run-operation good_macro --args '{arg_1: value_1}'"]
  generate_docs          = false
  name                   = "Test 11 - Complex"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_146088.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_128120" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_117108.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt --use-experimental-parser run -s good_model bad_model --vars '{\"key\": \"value\"}'"]
  generate_docs          = false
  name                   = "Test 12 - Experimental Parser"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_146088.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_128138" {
  dbt_version            = "1.4.0-latest"
  environment_id         = dbtcloud_environment.terraform_managed_resource_117108.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt build -s +order_items_bad+", "dbt run-operation good_macro", "dbt docs generate"]
  generate_docs          = false
  name                   = "Test 13 - Bad Pipeline"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_146088.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_128218" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_117108.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt run -x", "dbt build --fail-fast", "dbt docs generate"]
  generate_docs          = false
  name                   = "Test 14 - Fail Fast"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_146088.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_135261" {
  deferring_environment_id = dbtcloud_environment.terraform_managed_resource_117108.environment_id
  environment_id           = dbtcloud_environment.terraform_managed_resource_117108.environment_id
  errors_on_lint_failure   = true
  execute_steps            = ["dbt build"]
  generate_docs            = true
  name                     = "TestTestTest"
  num_threads              = 4
  project_id               = dbtcloud_project.terraform_managed_resource_146088.id
  run_compare_changes      = false
  run_generate_sources     = true
  run_lint                 = false
  schedule_days            = [4, 6]
  schedule_hours           = [0]
  schedule_type            = "days_of_week"
  target_name              = "default"
  timeout_seconds          = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_135277" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_117108.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt run"]
  generate_docs          = false
  name                   = "Normal Prod Run-cloned-job"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_146088.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_154047" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_117108.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt build -s state:modified+"]
  generate_docs          = false
  name                   = "CI Job"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_146088.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_229335" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_117108.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt run -s good_model"]
  generate_docs          = false
  name                   = "Good Job"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_146088.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_361557" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_172249.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt build"]
  generate_docs          = true
  name                   = "Daily Job"
  num_threads            = 8
  project_id             = dbtcloud_project.terraform_managed_resource_189133.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_hours         = [1]
  schedule_type          = "days_of_week"
  target_name            = "prod"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_362121" {
  deferring_environment_id = dbtcloud_environment.terraform_managed_resource_172249.environment_id
  environment_id           = dbtcloud_environment.terraform_managed_resource_210259.environment_id
  errors_on_lint_failure   = true
  execute_steps            = ["dbt build -s state:modified+"]
  generate_docs            = false
  name                     = "CI Job"
  num_threads              = 5
  project_id               = dbtcloud_project.terraform_managed_resource_189133.id
  run_compare_changes      = true
  run_generate_sources     = false
  run_lint                 = false
  schedule_days            = [0, 1, 2, 3, 4, 5, 6]
  schedule_type            = "days_of_week"
  target_name              = "ci"
  timeout_seconds          = 3600
  triggers = {
    git_provider_webhook = false
    github_webhook       = true
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_384676" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_218762.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt build"]
  generate_docs          = true
  name                   = "Daily Job"
  num_threads            = 16
  project_id             = dbtcloud_project.terraform_managed_resource_270542.id
  run_compare_changes    = false
  run_generate_sources   = true
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_hours         = [13]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
  job_completion_trigger_condition {
    job_id     = dbtcloud_job.terraform_managed_resource_106100.id
    project_id = dbtcloud_project.terraform_managed_resource_131414.id
    statuses   = ["success"]
  }
}

resource "dbtcloud_job" "terraform_managed_resource_394279" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_218762.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt run -s +fct_order_items+ --exclude stg_tpch_orders stg_tpch_parts --exclude \"stg_tpch_line_items\""]
  generate_docs          = false
  name                   = "Hourly Job"
  num_threads            = 8
  project_id             = dbtcloud_project.terraform_managed_resource_270542.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_475327" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_308743.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt run"]
  generate_docs          = false
  name                   = "Compile Job"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_270542.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_503518" {
  deferring_environment_id = dbtcloud_environment.terraform_managed_resource_218762.environment_id
  environment_id           = dbtcloud_environment.terraform_managed_resource_218762.environment_id
  errors_on_lint_failure   = true
  execute_steps            = ["dbt run -s +fct_order_items+ --exclude stg_tpch_orders stg_tpch_parts --exclude stg_tpch_line_items"]
  generate_docs            = false
  name                     = "Concurrent Job"
  num_threads              = 4
  project_id               = dbtcloud_project.terraform_managed_resource_270542.id
  run_compare_changes      = false
  run_generate_sources     = false
  run_lint                 = false
  schedule_days            = [0, 1, 2, 3, 4, 5, 6]
  schedule_type            = "days_of_week"
  target_name              = "default"
  timeout_seconds          = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_505512" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_282003.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt compile"]
  generate_docs          = true
  name                   = "Compile Job"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_338153.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_505516" {
  deferring_environment_id = dbtcloud_environment.terraform_managed_resource_282003.environment_id
  description              = "Run Continuous Integration job"
  environment_id           = dbtcloud_environment.terraform_managed_resource_282002.environment_id
  errors_on_lint_failure   = true
  execute_steps            = ["dbt build --select state:modified+"]
  generate_docs            = false
  name                     = "CI Job"
  num_threads              = 8
  project_id               = dbtcloud_project.terraform_managed_resource_338153.id
  run_compare_changes      = false
  run_generate_sources     = false
  run_lint                 = false
  schedule_days            = [0, 1, 2, 3, 4, 5, 6]
  schedule_type            = "days_of_week"
  target_name              = "default"
  timeout_seconds          = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_505519" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_282003.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt build"]
  generate_docs          = true
  name                   = "Daily Job"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_338153.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_hours         = [23]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
  job_completion_trigger_condition {
    job_id     = dbtcloud_job.terraform_managed_resource_106100.id
    project_id = dbtcloud_project.terraform_managed_resource_131414.id
    statuses   = ["success"]
  }
}

resource "dbtcloud_job" "terraform_managed_resource_506159" {
  deferring_environment_id = dbtcloud_environment.terraform_managed_resource_282305.environment_id
  environment_id           = dbtcloud_environment.terraform_managed_resource_282304.environment_id
  errors_on_lint_failure   = true
  execute_steps            = ["dbt build --select state:modified+"]
  generate_docs            = false
  name                     = "CI Job"
  num_threads              = 8
  project_id               = dbtcloud_project.terraform_managed_resource_334748.id
  run_compare_changes      = false
  run_generate_sources     = false
  run_lint                 = false
  schedule_days            = [0, 1, 2, 3, 4, 5, 6]
  schedule_type            = "days_of_week"
  target_name              = "default"
  timeout_seconds          = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_506161" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_282305.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt build"]
  generate_docs          = true
  name                   = "Daily Job"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_334748.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_hours         = [23]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
  job_completion_trigger_condition {
    job_id     = dbtcloud_job.terraform_managed_resource_384676.id
    project_id = dbtcloud_project.terraform_managed_resource_270542.id
    statuses   = ["success"]
  }
}

resource "dbtcloud_job" "terraform_managed_resource_521771" {
  deferring_environment_id = dbtcloud_environment.terraform_managed_resource_288698.environment_id
  environment_id           = dbtcloud_environment.terraform_managed_resource_288699.environment_id
  errors_on_lint_failure   = true
  execute_steps            = ["dbt build --select state:modified+"]
  generate_docs            = false
  name                     = "CI Job"
  num_threads              = 4
  project_id               = dbtcloud_project.terraform_managed_resource_345530.id
  run_compare_changes      = false
  run_generate_sources     = false
  run_lint                 = false
  schedule_days            = [0, 1, 2, 3, 4, 5, 6]
  schedule_type            = "days_of_week"
  target_name              = "default"
  timeout_seconds          = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = true
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_521772" {
  deferring_environment_id = dbtcloud_environment.terraform_managed_resource_288698.environment_id
  environment_id           = dbtcloud_environment.terraform_managed_resource_288698.environment_id
  errors_on_lint_failure   = true
  execute_steps            = ["dbt run -s state:modified+"]
  generate_docs            = true
  name                     = "Merge Job"
  num_threads              = 8
  project_id               = dbtcloud_project.terraform_managed_resource_345530.id
  run_compare_changes      = false
  run_generate_sources     = false
  run_lint                 = false
  schedule_days            = [0, 1, 2, 3, 4, 5, 6]
  schedule_type            = "days_of_week"
  target_name              = "default"
  timeout_seconds          = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_521774" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_288698.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt compile"]
  generate_docs          = false
  name                   = "Compile Job"
  num_threads            = 8
  project_id             = dbtcloud_project.terraform_managed_resource_345530.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_days          = [0, 1, 2, 3, 4, 5, 6]
  schedule_type          = "days_of_week"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_562478" {
  deferring_environment_id = dbtcloud_environment.terraform_managed_resource_308743.environment_id
  description              = "This is the second step in our blue-green deploy and will be triggered based on if the Blue Job is successful."
  environment_id           = dbtcloud_environment.terraform_managed_resource_218762.environment_id
  errors_on_lint_failure   = true
  execute_steps            = ["dbt clone --threads 1000 --full-refresh --exclude-resource-type snapshot"]
  generate_docs            = true
  name                     = "Green Job"
  num_threads              = 16
  project_id               = dbtcloud_project.terraform_managed_resource_270542.id
  run_compare_changes      = false
  run_generate_sources     = false
  run_lint                 = false
  schedule_cron            = "7 */12 * * 0,1,2,3,4,5,6"
  schedule_type            = "custom_cron"
  target_name              = "default"
  timeout_seconds          = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
  job_completion_trigger_condition {
    job_id     = dbtcloud_job.terraform_managed_resource_583093.id
    project_id = dbtcloud_project.terraform_managed_resource_270542.id
    statuses   = ["success"]
  }
}

resource "dbtcloud_job" "terraform_managed_resource_567183" {
  dbt_version              = "latest"
  deferring_environment_id = dbtcloud_environment.terraform_managed_resource_218762.environment_id
  environment_id           = dbtcloud_environment.terraform_managed_resource_308752.environment_id
  errors_on_lint_failure   = true
  execute_steps            = ["dbt build --select state:modified+"]
  generate_docs            = false
  name                     = "CI Job"
  num_threads              = 16
  project_id               = dbtcloud_project.terraform_managed_resource_270542.id
  run_compare_changes      = false
  run_generate_sources     = false
  run_lint                 = false
  schedule_cron            = "7 */12 * * 0,1,2,3,4,5,6"
  schedule_type            = "custom_cron"
  target_name              = "default"
  timeout_seconds          = 3600
  triggers = {
    git_provider_webhook = false
    github_webhook       = true
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_583093" {
  description            = "This is the first step in our blue-green deploy.  If this succeeds, a Green Job will be triggered immediately after."
  environment_id         = dbtcloud_environment.terraform_managed_resource_308743.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt run -s total_revenue"]
  generate_docs          = true
  name                   = "Blue Job"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_270542.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_cron          = "7 */12 * * 0,1,2,3,4,5,6"
  schedule_type          = "custom_cron"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_676075" {
  deferring_environment_id = dbtcloud_environment.terraform_managed_resource_218762.environment_id
  environment_id           = dbtcloud_environment.terraform_managed_resource_308743.environment_id
  errors_on_lint_failure   = true
  execute_steps            = ["dbt build --select state:modified+"]
  generate_docs            = false
  name                     = "Merge to QA"
  num_threads              = 4
  project_id               = dbtcloud_project.terraform_managed_resource_270542.id
  run_compare_changes      = false
  run_generate_sources     = false
  run_lint                 = false
  schedule_cron            = "7 */12 * * 0,1,2,3,4,5,6"
  schedule_type            = "custom_cron"
  target_name              = "default"
  timeout_seconds          = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = true
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_679202" {
  deferring_environment_id = dbtcloud_environment.terraform_managed_resource_172249.environment_id
  environment_id           = dbtcloud_environment.terraform_managed_resource_172249.environment_id
  errors_on_lint_failure   = true
  execute_steps            = ["dbt run --select state:modified+"]
  generate_docs            = false
  name                     = "Merge Job"
  num_threads              = 4
  project_id               = dbtcloud_project.terraform_managed_resource_189133.id
  run_compare_changes      = false
  run_generate_sources     = false
  run_lint                 = false
  schedule_cron            = "7 */12 * * 0,1,2,3,4,5,6"
  schedule_type            = "custom_cron"
  target_name              = "default"
  timeout_seconds          = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = true
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_699373" {
  deferring_environment_id = dbtcloud_environment.terraform_managed_resource_218762.environment_id
  description              = "Runs when code is merged into the main branch. Will only run the things that were modified in the pull request."
  environment_id           = dbtcloud_environment.terraform_managed_resource_218762.environment_id
  errors_on_lint_failure   = true
  execute_steps            = ["dbt run -s state:modified+", "dbt docs generate"]
  generate_docs            = false
  name                     = "Merge Job"
  num_threads              = 16
  project_id               = dbtcloud_project.terraform_managed_resource_270542.id
  run_compare_changes      = false
  run_generate_sources     = false
  run_lint                 = false
  schedule_cron            = "7 */12 * * 0,1,2,3,4,5,6"
  schedule_type            = "custom_cron"
  target_name              = "default"
  timeout_seconds          = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = true
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_763139" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_339105.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt build"]
  generate_docs          = true
  name                   = "Daily job"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_385562.id
  run_compare_changes    = false
  run_generate_sources   = true
  run_lint               = false
  schedule_cron          = "7 */12 * * 1,2,3,4,5"
  schedule_type          = "custom_cron"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_765321" {
  deferring_environment_id = dbtcloud_environment.terraform_managed_resource_339105.environment_id
  environment_id           = dbtcloud_environment.terraform_managed_resource_339531.environment_id
  errors_on_lint_failure   = true
  execute_steps            = ["dbt build --select state:modified+"]
  generate_docs            = false
  name                     = "CI Job"
  num_threads              = 16
  project_id               = dbtcloud_project.terraform_managed_resource_385562.id
  run_compare_changes      = false
  run_generate_sources     = false
  run_lint                 = false
  schedule_cron            = "7 */12 * * 0,1,2,3,4,5,6"
  schedule_type            = "custom_cron"
  target_name              = "default"
  timeout_seconds          = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = true
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_765322" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_339105.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt compile"]
  generate_docs          = true
  name                   = "Compile Job"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_385562.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_cron          = "7 */12 * * 0,1,2,3,4,5,6"
  schedule_type          = "custom_cron"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_765328" {
  deferring_environment_id = dbtcloud_environment.terraform_managed_resource_339105.environment_id
  environment_id           = dbtcloud_environment.terraform_managed_resource_339105.environment_id
  errors_on_lint_failure   = true
  execute_steps            = ["dbt run --select state:modified+"]
  generate_docs            = false
  name                     = "Merge Job"
  num_threads              = 16
  project_id               = dbtcloud_project.terraform_managed_resource_385562.id
  run_compare_changes      = false
  run_generate_sources     = false
  run_lint                 = false
  schedule_cron            = "7 */12 * * 0,1,2,3,4,5,6"
  schedule_type            = "custom_cron"
  target_name              = "default"
  timeout_seconds          = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = true
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_773069" {
  environment_id         = dbtcloud_environment.terraform_managed_resource_341022.environment_id
  errors_on_lint_failure = true
  execute_steps          = ["dbt parse"]
  generate_docs          = false
  name                   = "Parse Job"
  num_threads            = 4
  project_id             = dbtcloud_project.terraform_managed_resource_386635.id
  run_compare_changes    = false
  run_generate_sources   = false
  run_lint               = false
  schedule_cron          = "7 */12 * * 0,1,2,3,4,5,6"
  schedule_type          = "custom_cron"
  target_name            = "default"
  timeout_seconds        = 0
  triggers = {
    git_provider_webhook = false
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_job" "terraform_managed_resource_773070" {
  deferring_environment_id = dbtcloud_environment.terraform_managed_resource_341022.environment_id
  environment_id           = dbtcloud_environment.terraform_managed_resource_341022.environment_id
  errors_on_lint_failure   = true
  execute_steps            = ["dbt build --select state:modified+"]
  generate_docs            = false
  name                     = "CI Job"
  num_threads              = 4
  project_id               = dbtcloud_project.terraform_managed_resource_386635.id
  run_compare_changes      = false
  run_generate_sources     = false
  run_lint                 = false
  schedule_cron            = "7 */12 * * 0,1,2,3,4,5,6"
  schedule_type            = "custom_cron"
  target_name              = "default"
  timeout_seconds          = 0
  triggers = {
    git_provider_webhook = true
    github_webhook       = false
    on_merge             = false
    schedule             = false
  }
  triggers_on_draft_pr = false
}

resource "dbtcloud_project" "terraform_managed_resource_131414" {
  description = "# Heading 1\nThis is my main project\n\n## Heading 2\nIt's certainly the best project."
  name        = "Segment"
}

resource "dbtcloud_project" "terraform_managed_resource_146088" {
  name = "dbtc Testing"
}

resource "dbtcloud_project" "terraform_managed_resource_189133" {
  name = "Databricks"
}

resource "dbtcloud_project" "terraform_managed_resource_270542" {
  description = "This project has information related to our application database (think orders, customers, and suppliers) and third party investment data.  Use this site to explore how data is transformed, how things are defined, and what things depend on one another."
  name        = "Main"
}

resource "dbtcloud_project" "terraform_managed_resource_334748" {
  name = "Investment Research"
}

resource "dbtcloud_project" "terraform_managed_resource_338153" {
  name = "Product Analytics"
}

resource "dbtcloud_project" "terraform_managed_resource_345530" {
  name = "Customer Metrics"
}

resource "dbtcloud_project" "terraform_managed_resource_385562" {
  name = "POC"
}

resource "dbtcloud_project" "terraform_managed_resource_386635" {
  name = "TestingADO"
}

resource "dbtcloud_project" "terraform_managed_resource_390352" {
  name = "sdf"
}

resource "dbtcloud_project_repository" "terraform_managed_resource_131414" {
  project_id    = dbtcloud_project.terraform_managed_resource_131414.id
  repository_id = dbtcloud_repository.terraform_managed_resource_84144.repository_id
}

resource "dbtcloud_project_repository" "terraform_managed_resource_146088" {
  project_id    = dbtcloud_project.terraform_managed_resource_146088.id
  repository_id = dbtcloud_repository.terraform_managed_resource_92314.repository_id
}

resource "dbtcloud_project_repository" "terraform_managed_resource_189133" {
  project_id    = dbtcloud_project.terraform_managed_resource_189133.id
  repository_id = dbtcloud_repository.terraform_managed_resource_112598.repository_id
}

resource "dbtcloud_project_repository" "terraform_managed_resource_270542" {
  project_id    = dbtcloud_project.terraform_managed_resource_270542.id
  repository_id = dbtcloud_repository.terraform_managed_resource_163513.repository_id
}

resource "dbtcloud_project_repository" "terraform_managed_resource_334748" {
  project_id    = dbtcloud_project.terraform_managed_resource_334748.id
  repository_id = dbtcloud_repository.terraform_managed_resource_200551.repository_id
}

resource "dbtcloud_project_repository" "terraform_managed_resource_338153" {
  project_id    = dbtcloud_project.terraform_managed_resource_338153.id
  repository_id = dbtcloud_repository.terraform_managed_resource_202498.repository_id
}

resource "dbtcloud_project_repository" "terraform_managed_resource_345530" {
  project_id    = dbtcloud_project.terraform_managed_resource_345530.id
  repository_id = dbtcloud_repository.terraform_managed_resource_206756.repository_id
}

resource "dbtcloud_project_repository" "terraform_managed_resource_385562" {
  project_id    = dbtcloud_project.terraform_managed_resource_385562.id
  repository_id = dbtcloud_repository.terraform_managed_resource_237271.repository_id
}

resource "dbtcloud_project_repository" "terraform_managed_resource_386635" {
  project_id    = dbtcloud_project.terraform_managed_resource_386635.id
  repository_id = dbtcloud_repository.terraform_managed_resource_236415.repository_id
}

resource "dbtcloud_project_repository" "terraform_managed_resource_390352" {
  project_id    = dbtcloud_project.terraform_managed_resource_390352.id
  repository_id = dbtcloud_repository.terraform_managed_resource_237742.repository_id
}

resource "dbtcloud_repository" "terraform_managed_resource_84144" {
  git_clone_strategy        = "github_app"
  github_installation_id    = 22596234
  project_id                = dbtcloud_project.terraform_managed_resource_131414.id
  pull_request_url_template = "https://github.com/dpguthrie/upstream-project/compare/{{destination}}...{{source}}"
  remote_url                = "git://github.com/dpguthrie/upstream-project.git"
}

resource "dbtcloud_repository" "terraform_managed_resource_92313" {
  git_clone_strategy        = "github_app"
  github_installation_id    = 22596234
  project_id                = dbtcloud_project.terraform_managed_resource_146088.id
  pull_request_url_template = "https://github.com/dpguthrie/snowflake-dbt-demo-project/compare/{{destination}}...{{source}}"
  remote_url                = "git://github.com/dpguthrie/snowflake-dbt-demo-project.git"
}

resource "dbtcloud_repository" "terraform_managed_resource_92314" {
  git_clone_strategy        = "github_app"
  github_installation_id    = 22596234
  project_id                = dbtcloud_project.terraform_managed_resource_146088.id
  pull_request_url_template = "https://github.com/dpguthrie/dbtc-testing-project/compare/{{destination}}...{{source}}"
  remote_url                = "git://github.com/dpguthrie/dbtc-testing-project.git"
}

resource "dbtcloud_repository" "terraform_managed_resource_112598" {
  git_clone_strategy        = "github_app"
  github_installation_id    = 22596234
  project_id                = dbtcloud_project.terraform_managed_resource_189133.id
  pull_request_url_template = "https://github.com/dpguthrie/dbt-databricks/compare/{{destination}}...{{source}}"
  remote_url                = "git://github.com/dpguthrie/dbt-databricks.git"
}

resource "dbtcloud_repository" "terraform_managed_resource_163513" {
  git_clone_strategy        = "github_app"
  github_installation_id    = 22596234
  project_id                = dbtcloud_project.terraform_managed_resource_270542.id
  pull_request_url_template = "https://github.com/dpguthrie/snowflake-dbt-demo-new/compare/{{destination}}...{{source}}"
  remote_url                = "git://github.com/dpguthrie/snowflake-dbt-demo-new.git"
}

resource "dbtcloud_repository" "terraform_managed_resource_200551" {
  git_clone_strategy        = "github_app"
  github_installation_id    = 22596234
  project_id                = dbtcloud_project.terraform_managed_resource_334748.id
  pull_request_url_template = "https://github.com/dpguthrie/dbt-stonks-project/compare/{{destination}}...{{source}}"
  remote_url                = "git://github.com/dpguthrie/dbt-stonks-project.git"
}

resource "dbtcloud_repository" "terraform_managed_resource_202498" {
  git_clone_strategy        = "github_app"
  github_installation_id    = 22596234
  project_id                = dbtcloud_project.terraform_managed_resource_338153.id
  pull_request_url_template = "https://github.com/dpguthrie/downstream-test/compare/{{destination}}...{{source}}"
  remote_url                = "git://github.com/dpguthrie/downstream-test.git"
}

resource "dbtcloud_repository" "terraform_managed_resource_206756" {
  git_clone_strategy        = "github_app"
  github_installation_id    = 22596234
  project_id                = dbtcloud_project.terraform_managed_resource_345530.id
  pull_request_url_template = "https://github.com/dpguthrie/dbt-customer-metrics-project/compare/{{destination}}...{{source}}"
  remote_url                = "git://github.com/dpguthrie/dbt-customer-metrics-project.git"
}

resource "dbtcloud_repository" "terraform_managed_resource_236415" {
  git_clone_strategy        = "azure_active_directory_app"
  project_id                = dbtcloud_project.terraform_managed_resource_386635.id
  pull_request_url_template = "https://dev.azure.com/dpguthrie/dbt/_git/dbt-poc/pullrequestcreate?sourceRef={{source}}&targetRef={{destination}}"
  remote_url                = "https://dpguthrie@dev.azure.com/dpguthrie/dbt/_git/dbt-poc"
}

resource "dbtcloud_repository" "terraform_managed_resource_237271" {
  git_clone_strategy        = "azure_active_directory_app"
  project_id                = dbtcloud_project.terraform_managed_resource_385562.id
  pull_request_url_template = "https://dev.azure.com/dpguthrie/dbt/_git/dbt-poc/pullrequestcreate?sourceRef={{source}}&targetRef={{destination}}"
  remote_url                = "https://dpguthrie@dev.azure.com/dpguthrie/dbt/_git/dbt-poc"
}

resource "dbtcloud_repository" "terraform_managed_resource_237742" {
  git_clone_strategy        = "github_app"
  github_installation_id    = 267820
  project_id                = dbtcloud_project.terraform_managed_resource_390352.id
  pull_request_url_template = "https://github.com/dbt-labs/internal-analytics/compare/{{destination}}...{{source}}"
  remote_url                = "git://github.com/dbt-labs/internal-analytics.git"
}

resource "dbtcloud_snowflake_credential" "terraform_managed_resource_144378" {
  auth_type   = "password"
  num_threads = 4
  password    = "---TBD---"
  project_id  = dbtcloud_project.terraform_managed_resource_131414.id
  schema      = "upstream"
  user        = "DOUG_G2"
}

resource "dbtcloud_snowflake_credential" "terraform_managed_resource_157658" {
  auth_type   = "password"
  database    = "DOUG_DEMO_V2"
  num_threads = 4
  password    = "---TBD---"
  project_id  = dbtcloud_project.terraform_managed_resource_146088.id
  schema      = "ANALYTICS_TEST"
  user        = "DOUG_G"
  warehouse   = "TRANSFORMING"
}

resource "dbtcloud_snowflake_credential" "terraform_managed_resource_279952" {
  auth_type   = "password"
  database    = "DOUG_DEMO_V2"
  num_threads = 4
  password    = "---TBD---"
  project_id  = dbtcloud_project.terraform_managed_resource_270542.id
  schema      = "ANALYTICS"
  user        = "DOUG_G2"
  warehouse   = "TRANSFORMING"
}

resource "dbtcloud_snowflake_credential" "terraform_managed_resource_334614" {
  auth_type   = "password"
  database    = "DOUG_DEMO_V2"
  num_threads = 4
  password    = "---TBD---"
  project_id  = dbtcloud_project.terraform_managed_resource_131414.id
  schema      = "analytics_ci"
  user        = "DOUG_G2"
  warehouse   = "TRANSFORMING"
}

resource "dbtcloud_snowflake_credential" "terraform_managed_resource_352995" {
  auth_type   = "password"
  database    = "DOUG_DEMO_V2"
  num_threads = 4
  password    = "---TBD---"
  project_id  = dbtcloud_project.terraform_managed_resource_338153.id
  schema      = "ANALYTICS_CI"
  user        = "DOUG_G2"
  warehouse   = "TRANSFORMING"
}

resource "dbtcloud_snowflake_credential" "terraform_managed_resource_352996" {
  auth_type   = "password"
  database    = "DOUG_DEMO_V2"
  num_threads = 4
  password    = "---TBD---"
  project_id  = dbtcloud_project.terraform_managed_resource_338153.id
  schema      = "ANALYTICS"
  user        = "DOUG_G2"
  warehouse   = "TRANSFORMING"
}

resource "dbtcloud_snowflake_credential" "terraform_managed_resource_353367" {
  auth_type   = "password"
  database    = "DOUG_DEMO_V2"
  num_threads = 4
  password    = "---TBD---"
  project_id  = dbtcloud_project.terraform_managed_resource_334748.id
  schema      = "ANALYTICS_CI"
  user        = "DOUG_G2"
  warehouse   = "TRANSFORMING"
}

resource "dbtcloud_snowflake_credential" "terraform_managed_resource_353368" {
  auth_type   = "password"
  database    = "DOUG_DEMO_V2"
  num_threads = 4
  password    = "---TBD---"
  project_id  = dbtcloud_project.terraform_managed_resource_334748.id
  schema      = "ANALYTICS"
  user        = "DOUG_G2"
  warehouse   = "TRANSFORMING"
}

resource "dbtcloud_snowflake_credential" "terraform_managed_resource_360698" {
  auth_type   = "password"
  database    = "DOUG_DEMO_V2"
  num_threads = 4
  password    = "---TBD---"
  project_id  = dbtcloud_project.terraform_managed_resource_345530.id
  schema      = "ANALYTICS"
  user        = "DOUG_G2"
  warehouse   = "TRANSFORMING"
}

resource "dbtcloud_snowflake_credential" "terraform_managed_resource_360699" {
  auth_type   = "password"
  database    = "DOUG_DEMO_V2"
  num_threads = 4
  password    = "---TBD---"
  project_id  = dbtcloud_project.terraform_managed_resource_345530.id
  schema      = "ANALYTICS_CI"
  user        = "DOUG_G2"
  warehouse   = "TRANSFORMING"
}

resource "dbtcloud_snowflake_credential" "terraform_managed_resource_384630" {
  auth_type   = "password"
  database    = "DOUG_DEMO_V2"
  num_threads = 4
  password    = "---TBD---"
  project_id  = dbtcloud_project.terraform_managed_resource_270542.id
  schema      = "STAGING"
  user        = "DOUG_G2"
  warehouse   = "TRANSFORMING"
}

resource "dbtcloud_snowflake_credential" "terraform_managed_resource_384641" {
  auth_type   = "password"
  database    = "DOUG_DEMO_V2"
  num_threads = 4
  password    = "---TBD---"
  project_id  = dbtcloud_project.terraform_managed_resource_270542.id
  schema      = "CI"
  user        = "DOUG_G2"
  warehouse   = "TRANSFORMING"
}

resource "dbtcloud_snowflake_credential" "terraform_managed_resource_428348" {
  auth_type   = "password"
  database    = "DOUG_DEMO_V2"
  num_threads = 4
  password    = "---TBD---"
  project_id  = dbtcloud_project.terraform_managed_resource_385562.id
  schema      = "ANALYTICS"
  user        = "DOUG_G2"
  warehouse   = "TRANSFORMING"
}

resource "dbtcloud_snowflake_credential" "terraform_managed_resource_428981" {
  auth_type   = "password"
  database    = "DOUG_DEMO_V2"
  num_threads = 4
  password    = "---TBD---"
  project_id  = dbtcloud_project.terraform_managed_resource_385562.id
  schema      = "CI"
  user        = "DOUG_G2"
  warehouse   = "TRANSFORMING"
}

resource "dbtcloud_snowflake_credential" "terraform_managed_resource_431310" {
  auth_type   = "password"
  database    = "DOUG_DEMO_V2"
  num_threads = 4
  password    = "---TBD---"
  project_id  = dbtcloud_project.terraform_managed_resource_386635.id
  schema      = "ANALYTICS"
  user        = "DOUG_G2"
  warehouse   = "TRANSFORMING"
}

resource "dbtcloud_snowflake_credential" "terraform_managed_resource_431814" {
  auth_type   = "password"
  database    = "DOUG_DEMO_V2"
  num_threads = 4
  password    = "---TBD---"
  project_id  = dbtcloud_project.terraform_managed_resource_385562.id
  schema      = "QA"
  user        = "DOUG_G2"
  warehouse   = "TRANSFORMING"
}

