pipeline "add_labels_to_compute_image" {
  title       = "Add Labels to Compute Image"
  description = "This pipeline adds labels to a Google Compute Engine virtual machine image."

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

  param "labels" {
    type        = map(string)
    description = "The GCP labels."
  }

  step "container" "add_labels_to_compute_image" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(
      ["gcloud", "compute", "images", "add-labels", param.image_name, "--format=json", "--labels"],
      [join(",", [for key, value in param.labels : "${key}=${value}"])]
    )
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "image" {
    description = "Information about the GCP compute image."
    value       = jsondecode(step.container.add_labels_to_compute_image.stdout)
  }
}
