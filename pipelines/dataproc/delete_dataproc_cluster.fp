pipeline "delete_dataproc_cluster" {
  title       = "Delete Dataproc Cluster"
  description = "This pipeline deletes a Google Cloud Dataproc cluster."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "region" {
    type        = string
    description = "The region where the Dataproc cluster is located."
  }

  param "cluster_name" {
    type        = string
    description = "The name of the Dataproc cluster to delete."
  }

  step "container" "delete_dataproc_cluster" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = [
      "gcloud", "dataproc", "clusters", "delete", param.cluster_name,
      "--region", param.region,
      "--quiet", "--format=json"
    ]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "dataproc_cluster_deletion_info" {
    description = "Information about the deleted Dataproc cluster."
    value       = jsondecode(step.container.delete_dataproc_cluster.stdout)
  }
}
