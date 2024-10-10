pipeline "remove_specific_label_from_compute_image" {
  title       = "Remove Specific Label from Compute Image"
  description = "This pipeline removes specific labels from a Google Compute Engine virtual machine image."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "image_name" {
    type        = string
    description = "The GCP image name."
  }

  param "label_keys" {
    type        = list(string)
    description = "The GCP labels."
  }

  step "container" "remove_specific_label_from_compute_image" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "images", "remove-labels", param.image_name, "--labels", join(",", param.label_keys), "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "image" {
    description = "Information about the GCP compute image."
    value       = jsondecode(step.container.remove_specific_label_from_compute_image.stdout)
  }
}
