## v1.0.0 (2024-10-22)

_Breaking changes_

- Flowpipe `v1.0.0` is now required. For a full list of CLI changes, please see the [Flowpipe v1.0.0 CHANGELOG](https://flowpipe.io/changelog/flowpipe-cli-v1-0-0).
- In Flowpipe configuration files (`.fpc`), `credential` and `credential_import` resources have been renamed to `connection` and `connection_import` respectively.
- Renamed all `cred` params to `conn` and updated their types from `string` to `conn`.

_Enhancements_

- Added `library` to the mod's categories.
- Updated the following pipeline tags:
  - `type = "featured"` to `recommended = "true"`
  - `type = "test"` to `folder = "Tests"`

## v0.3.0 [2024-07-24]

_What's new?_

- Added 52 new pipelines for seamless integration with your Compute, DataProc, DNS, IAM, KMS, Storage resources, and more. ([#10](https://github.com/turbot/flowpipe-mod-gcp/pull/10))

## v0.2.0 [2024-02-02]

_Bug fixes_

- Fix the commands in `add_labels_to_compute_disk` and `add_labels_to_compute_instance` pipelines. ([#7](https://github.com/turbot/flowpipe-mod-gcp/pull/7))

## v0.1.0 [2023-12-13]

_What's new?_

- Added 35+ pipelines to make it easy to connect your Compute Instance, Storage Bucket, PubSub, VPC resources and more. For usage information and a full list of pipelines, please see [GCP Mod for Flowpipe](https://hub.flowpipe.io/mods/turbot/gcp).
