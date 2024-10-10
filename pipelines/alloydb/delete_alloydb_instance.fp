pipeline "delete_alloydb_instance" {
  title       = "Delete AlloyDB Instance"
  description = "This pipeline deletes a Google Cloud AlloyDB instance."

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
    description = "The region where the AlloyDB instance is located."
  }

  param "cluster_name" {
    type        = string
    description = "The name of the AlloyDB cluster that contains the instance."
  }

  param "instance_name" {
    type        = string
    description = "The name of the AlloyDB instance to delete."
  }

  step "container" "delete_alloydb_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = [
      "gcloud", "alloydb", "instances", "delete", param.instance_name,
      "--region", param.region,
      "--cluster", param.cluster_name,
      "--quiet", "--format=json"
    ]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "alloydb_instance_deletion_info" {
    description = "Information about the deleted AlloyDB instance."
    value       = jsondecode(step.container.delete_alloydb_instance.stdout)
  }
}
