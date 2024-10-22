# GCP Mod for Flowpipe

GCP pipeline library for [Flowpipe](https://flowpipe.io), enabling seamless integration of GCP services into your workflows.

## Documentation

- **[Pipelines →](https://hub.flowpipe.io/mods/turbot/gcp/pipelines)**

## Getting started

### Requirements

Docker daemon must be installed and running. Please see [Install Docker Engine](https://docs.docker.com/engine/install/) for more information.

### Installation

Download and install Flowpipe (https://flowpipe.io/downloads). Or use Brew:

```sh
brew tap turbot/tap
brew install flowpipe
```

### Connections

By default, the following environment variables will be used for authentication:

- `GOOGLE_APPLICATION_CREDENTIALS`

You can also create `connection` resources in configuration files:

```sh
vi ~/.flowpipe/config/gcp.fpc
```

```hcl
connection "gcp" "gcp_token" {
  credentials = "path/to/credentials.json"
}
```

If no environment variables or configuration files are found, the mod will attempt to use [Application Default Credentials](https://cloud.google.com/docs/authentication/provide-credentials-adc) if configured.

For more information on connections in Flowpipe, please see [Managing Connections](https://flowpipe.io/docs/run/connections).

### Usage

[Initialize a mod](https://flowpipe.io/docs/build/index#initializing-a-mod):

```sh
mkdir my_mod
cd my_mod
flowpipe mod init
```

[Install the GCP mod](https://flowpipe.io/docs/build/mod-dependencies#mod-dependencies) as a dependency:

```sh
flowpipe mod install github.com/turbot/flowpipe-mod-gcp
```

[Use the dependency](https://flowpipe.io/docs/build/write-pipelines/index) in a pipeline step:

```sh
vi my_pipeline.fp
```

```hcl
pipeline "my_pipeline" {

  step "pipeline" "list_storage_buckets" {
    pipeline = gcp.pipeline.list_storage_buckets
    args = {
      project_id = "my-project"
    }
  }
}
```

[Run the pipeline](https://flowpipe.io/docs/run/pipelines):

```sh
flowpipe pipeline run my_pipeline
```

### Developing

Clone:

```sh
git clone https://github.com/turbot/flowpipe-mod-gcp.git
cd flowpipe-mod-gcp
```

List pipelines:

```sh
flowpipe pipeline list
```

Run a pipeline:

```sh
flowpipe pipeline run create_compute_instance --arg project_id=my-project --arg instance_name=i-1234567890abcdef0 --arg machine_type=n1-standard-1 --arg zone=us-central1-a --arg boot_disk_size="10"
```

To use a specific `connection`, specify the `conn` pipeline argument:

```sh
flowpipe pipeline run create_compute_instance --arg project_id=my-project --arg instance_name=i-1234567890abcdef0 --arg conn=connection.gcp.gcp_token --arg machine_type=n1-standard-1 --arg zone=us-central1-a --arg boot_disk_size="10"
```

## Open Source & Contributing

This repository is published under the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0). Please see our [code of conduct](https://github.com/turbot/.github/blob/main/CODE_OF_CONDUCT.md). We look forward to collaborating with you!

[Flowpipe](https://flowpipe.io) is a product produced from this open source software, exclusively by [Turbot HQ, Inc](https://turbot.com). It is distributed under our commercial terms. Others are allowed to make their own distribution of the software, but cannot use any of the Turbot trademarks, cloud services, etc. You can learn more in our [Open Source FAQ](https://turbot.com/open-source).

## Get Involved

**[Join #flowpipe on Slack →](https://flowpipe.io/community/join)**

Want to help but not sure where to start? Pick up one of the `help wanted` issues:

- [Flowpipe](https://github.com/turbot/flowpipe/labels/help%20wanted)
- [GCP Mod](https://github.com/turbot/flowpipe-mod-gcp/labels/help%20wanted)
