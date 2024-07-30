pipeline "add_labels_to_gke_cluster" {
  title       = "Add Labels to GKE Cluster"
  description = "This pipeline adds labels to a Google Kubernetes Engine (GKE) cluster."

  param "cred" {
    type        = string
    description = "GCP credentials to use"
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = "The GCP project ID."
  }

  param "cluster_name" {
    type        = string
    description = "The name of the GKE cluster."
  }

  param "location" {
    type        = string
    description = "The location (zone or region) of the GKE cluster."
  }

  param "labels" {
    type        = map(string)
    description = "The GCP labels to add."
  }

  step "container" "add_labels_to_gke_cluster" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "container", "clusters", "update", param.cluster_name, "--zone", param.location, "--update-labels", join(",", [for k, v in param.labels : "${k}=${v}"]), "--quiet", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "cluster" {
    description = "Information about the GKE cluster."
    value       = jsondecode(step.container.add_labels_to_gke_cluster.stdout)
  }
}