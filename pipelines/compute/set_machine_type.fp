pipeline "set_machine_type" {
  title       = "Set Machine Type"
  description = "This pipeline is used to set the machine type of a Compute Engine virtual machine. Changing the machine type stops the instance and starts it again with the new machine type."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "zone" {
    type        = string
    description = "The GCP zone."
  }

  param "instance_name" {
    type        = string
    description = "The GCP instance name."
  }

  param "machine_type" {
    type        = string
    description = "The new machine type to set for the instance."
  }

  step "container" "set_machine_type" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "instances", "set-machine-type", param.instance_name, "--zone", param.zone, "--machine-type", param.machine_type, "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }
}
