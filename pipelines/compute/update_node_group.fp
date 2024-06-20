pipeline "update_node_group" {
  title       = "Update Node Group"
  description = "This pipeline updates a sole-tenancy node group."

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

  param "node_group_name" {
    type        = string
    description = "The name of the node group."
  }

  param "autoscaler_mode" {
    type        = string
    description = "The autoscaler mode."
    optional    = true
  }

  param "max_nodes" {
    type        = number
    description = "The maximum number of nodes."
    optional    = true
  }

  step "container" "update_node_group" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(
      ["gcloud", "compute", "sole-tenancy", "node-groups", "update", param.node_group_name, "--zone", param.zone, "--format=json"],
      param.autoscaler_mode != null ? ["--autoscaler-mode", param.autoscaler_mode] : [],
      param.max_nodes != null ? ["--max-nodes", param.max_nodes] : []
    )
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }
}
