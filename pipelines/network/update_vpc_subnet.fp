pipeline "update_vpc_subnet" {
  title       = "Update VPC Subnet"
  description = "This pipeline updates a Google Compute Engine VPC subnet with optional parameters."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "region" {
    type        = string
    description = "The GCP region."
  }

  param "subnet_name" {
    type        = string
    description = "The name of the subnet."
  }

  param "enable_flow_logs" {
    type        = bool
    description = "Enable flow logs for the subnet."
    optional    = true
  }

  param "logging_aggregation_interval" {
    type        = string
    description = "The aggregation interval for logging."
    optional    = true
  }

  param "logging_flow_sampling" {
    type        = number
    description = "The flow sampling rate for logging."
    optional    = true
  }

  param "logging_metadata" {
    type        = string
    description = "The metadata for logging."
    optional    = true
  }

  step "container" "update_vpc_subnet" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(
      ["gcloud", "compute", "networks", "subnets", "update", param.subnet_name, "--region", param.region],
      param.enable_flow_logs != null ? ["--enable-flow-logs"] : [],
      param.logging_aggregation_interval != null ? ["--logging-aggregation-interval", param.logging_aggregation_interval] : [],
      param.logging_flow_sampling != null ? ["--logging-flow-sampling", tostring(param.logging_flow_sampling)] : [],
      param.logging_metadata != null ? ["--logging-metadata", param.logging_metadata] : [],
      ["--format=json"]
    )
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "subnet_info" {
    description = "Information about the updated subnet."
    value       = jsondecode(step.container.update_vpc_subnet.stdout)
  }
}
