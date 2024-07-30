pipeline "remove_labels_from_compute_forwarding_rule" {
  title       = "Remove Labels from Compute Forwarding Rule"
  description = "This pipeline removes specified labels from a Google Cloud Compute Forwarding Rule."

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

  param "label_keys" {
    type        = list(string)
    description = "The GCP label keys to remove."
  }

  step "container" "remove_labels_from_compute_forwarding_rule" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "forwarding-rules", "update", param.forwarding_rule_name, "--region", param.region, "--remove-labels", join(",", param.label_keys), "--quiet", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "forwarding_rule" {
    description = "Information about the Forwarding Rule."
    value       = jsondecode(step.container.remove_labels_from_compute_forwarding_rule.stdout)
  }
}