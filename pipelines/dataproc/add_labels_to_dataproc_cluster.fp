pipeline "add_labels_to_dataproc_cluster" {
  title       = "Add or Update Labels on Dataproc Cluster"
  description = "This pipeline adds or updates labels on a Google Cloud Dataproc cluster."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
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

  param "labels" {
    type        = map(string)
    description = "The GCP labels to add or update."
  }

  step "container" "add_labels_to_dataproc_cluster" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "dataproc", "clusters", "update", param.cluster_name, "--region", param.region, "--update-labels", join(",", [for k, v in param.labels : "${k}=${v}"]), "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "cluster" {
    description = "Information about the Dataproc cluster."
    value       = jsondecode(step.container.add_labels_to_dataproc_cluster.stdout)
  }
}
