pipeline "remove_labels_from_dataproc_cluster" {
  title       = "Remove Labels from Dataproc Cluster"
  description = "This pipeline removes specified labels from a Google Cloud Dataproc cluster."

  param "cred" {
    type        = string
    description = "GCP credentials to use"
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = "The GCP project ID."
  }

  param "region" {
    type        = string
    description = "The GCP region where the Dataproc cluster is located."
  }

  param "cluster_name" {
    type        = string
    description = "The name of the Dataproc cluster."
  }

  param "label_keys" {
    type        = list(string)
    description = "The GCP label keys to remove."
  }

  step "container" "remove_labels_from_dataproc_cluster" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "dataproc", "clusters", "update", param.cluster_name, "--region", param.region, "--remove-labels", join(",", param.label_keys), "--quiet", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "cluster" {
    description = "Information about the Dataproc cluster."
    value       = jsondecode(step.container.remove_labels_from_dataproc_cluster.stdout)
  }
}
