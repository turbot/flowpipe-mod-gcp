pipeline "delete_alloydb_cluster" {
  title       = "Delete AlloyDB Cluster"
  description = "This pipeline deletes a Google Cloud AlloyDB cluster."

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
    description = "The region where the AlloyDB cluster is located."
  }

  param "cluster_name" {
    type        = string
    description = "The name of the AlloyDB cluster to delete."
  }

  step "container" "delete_alloydb_cluster" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = [
      "gcloud", "alloydb", "clusters", "delete", param.cluster_name,
      "--region", param.region,
      "--quiet", "--format=json"
    ]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "alloydb_cluster_deletion_info" {
    description = "Information about the deleted AlloyDB cluster."
    value       = jsondecode(step.container.delete_alloydb_cluster.stdout)
  }
}
