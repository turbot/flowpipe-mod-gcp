pipeline "attach_compute_disk_to_instance" {
  title       = "Attach Compute Disk to Instance"
  description = "This pipeline is used to attach a disk to an instance."

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

  step "container" "attach_compute_disk_to_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "instances", "attach-disk", param.instance_name, "--disk", param.disk_name, "--zone", param.zone, "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "instance" {
    description = "Information about the GCP instance."
    value       = jsondecode(step.container.attach_compute_disk_to_instance.stdout)
  }
}
