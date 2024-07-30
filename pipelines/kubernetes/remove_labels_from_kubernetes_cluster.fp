pipeline "remove_labels_from_gke_cluster" {
  title       = "Remove Labels from GKE Cluster"
  description = "This pipeline removes specified labels from a Google Kubernetes Engine (GKE) cluster."

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

  param "label_keys" {
    type        = list(string)
    description = "The GCP label keys to remove."
  }

  step "container" "remove_labels_from_gke_cluster" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "container", "clusters", "update", param.cluster_name, "--zone", param.location, "--remove-labels", join(",", param.label_keys), "--quiet", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "cluster" {
    description = "Information about the GKE cluster."
    value       = jsondecode(step.container.remove_labels_from_gke_cluster.stdout)
  }
}