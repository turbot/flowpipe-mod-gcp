pipeline "attach_compute_instance_to_disk" {
  title       = "Attach a GCP compute instance to a disk"
  description = "This pipeline attaches a GCP compute instance to a disk."

  tags = {
    type = "featured"
  }

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
    default     = var.project_id
  }

  param "instance_name" {
    type        = string
    description = "The GCP instance name."
  }

  param "disk_name" {
    type        = string
    description = "The GCP disk name."
  }

  param "zone" {
    type        = string
    description = "The GCP zone."
  }

  step "container" "attach_compute_instance_to_disk" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "instances", "attach-disk", param.instance_name, "--disk", param.disk_name, "--zone", param.zone, "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "instance" {
    description = "Information about the GCP instance."
    value       = jsondecode(step.container.attach_compute_instance_to_disk.stdout)
  }
}