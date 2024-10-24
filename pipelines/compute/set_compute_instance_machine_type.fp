pipeline "set_compute_instance_machine_type" {
  title       = "Set Machine Type"
  description = "This pipeline is used to set the machine type of a Compute Engine virtual machine. Changing the machine type stops the instance and starts it again with the new machine type."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
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
    description = "The GCP compute instance name."
  }

  param "machine_type" {
    type        = string
    description = "The new machine type to set for the compute instance."
  }

  step "container" "set_compute_instance_machine_type" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "instances", "set-machine-type", param.instance_name, "--zone", param.zone, "--machine-type", param.machine_type, "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }
}
