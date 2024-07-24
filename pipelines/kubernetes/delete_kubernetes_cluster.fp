pipeline "delete_kubernetes_cluster" {
  title       = "Delete GKE Cluster"
  description = "This pipeline deletes a Google Kubernetes Engine (GKE) cluster."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "zone" {
    type        = string
    description = "The zone where the GKE cluster is located."
  }

  param "cluster_name" {
    type        = string
    description = "The name of the GKE cluster to delete."
  }

  step "container" "delete_kubernetes_cluster" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = [
      "gcloud", "container", "clusters", "delete", param.cluster_name,
      "--zone", param.zone,
      "--quiet", "--format=json"
    ]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "gke_cluster_deletion_info" {
    description = "Information about the deleted GKE cluster."
    value       = jsondecode(step.container.delete_kubernetes_cluster.stdout)
  }
}
