pipeline "add_labels_to_compute_forwarding_rule" {
  title       = "Add Labels to Compute Forwarding Rule"
  description = "This pipeline adds labels to a Google Cloud Compute Forwarding Rule."

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
    description = "The region where the Forwarding Rule is located."
  }

  param "forwarding_rule_name" {
    type        = string
    description = "The name of the Forwarding Rule."
  }

  param "labels" {
    type        = map(string)
    description = "The GCP labels to add."
  }

  step "container" "add_labels_to_compute_forwarding_rule" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "forwarding-rules", "update", param.forwarding_rule_name, "--region", param.region, "--update-labels", join(",", [for k, v in param.labels : "${k}=${v}"]), "--quiet", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "forwarding_rule" {
    description = "Information about the Forwarding Rule."
    value       = jsondecode(step.container.add_labels_to_compute_forwarding_rule.stdout)
  }
}