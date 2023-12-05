{
  "schema_version": "20221222",
  "start_time": "2023-12-05T20:57:28Z",
  "end_time": "2023-12-05T20:57:28Z",
  "layout": {
    "name": "pexec_clnote7e58ci0mg8fspg",
    "panel_type": "dashboard",
    "children": [
      {
        "name": "execution_tree",
        "panel_type": "graph"
      }
    ]
  },
  "panels": {
    "edge_start_pexec_clnote7e58ci0mg8fspg_to_step_container.list_storage_buckets": {
      "dashboard": "pexec_clnote7e58ci0mg8fspg",
      "name": "edge_start_pexec_clnote7e58ci0mg8fspg_to_step_container.list_storage_buckets",
      "panel_type": "edge",
      "status": "complete",
      "data": {
        "columns": [
          {
            "name": "from_id",
            "data_type": "TEXT"
          },
          {
            "name": "to_id",
            "data_type": "TEXT"
          }
        ],
        "rows": [
          {
            "from_id": "start_pexec_clnote7e58ci0mg8fspg",
            "to_id": "step_container.list_storage_buckets"
          }
        ]
      },
      "properties": {
        "name": "edge_start_pexec_clnote7e58ci0mg8fspg_to_step_container.list_storage_buckets"
      }
    },
    "edge_step_container.list_storage_buckets_to_end_pexec_clnote7e58ci0mg8fspg": {
      "dashboard": "pexec_clnote7e58ci0mg8fspg",
      "name": "edge_step_container.list_storage_buckets_to_end_pexec_clnote7e58ci0mg8fspg",
      "panel_type": "edge",
      "status": "complete",
      "data": {
        "columns": [
          {
            "name": "from_id",
            "data_type": "TEXT"
          },
          {
            "name": "to_id",
            "data_type": "TEXT"
          }
        ],
        "rows": [
          {
            "from_id": "step_container.list_storage_buckets",
            "to_id": "end_pexec_clnote7e58ci0mg8fspg"
          }
        ]
      },
      "properties": {
        "name": "edge_step_container.list_storage_buckets_to_end_pexec_clnote7e58ci0mg8fspg"
      }
    },
    "end_pexec_clnote7e58ci0mg8fspg": {
      "dashboard": "pexec_clnote7e58ci0mg8fspg",
      "name": "end_pexec_clnote7e58ci0mg8fspg",
      "panel_type": "node",
      "status": "complete",
      "title": "End: gcp.pipeline.list_storage_buckets",
      "data": {
        "columns": [
          {
            "name": "id",
            "data_type": "TEXT"
          },
          {
            "name": "title",
            "data_type": "TEXT"
          },
          {
            "name": "properties",
            "data_type": "JSONB"
          }
        ],
        "rows": [
          {
            "id": "end_pexec_clnote7e58ci0mg8fspg",
            "properties": {
              "Execution ID": "pexec_clnote7e58ci0mg8fspg",
              "Output": {
                "errors": [
                  {
                    "pipeline_execution_id": "pexec_clnote7e58ci0mg8fspg",
                    "step_execution_id": "sexec_clnote7e58ci0mg8fsqg",
                    "pipeline": "gcp.pipeline.list_storage_buckets",
                    "step": "container.list_storage_buckets",
                    "error": {
                      "instance": "fperr_clnote7e58ci0mg8fsr0",
                      "type": "error_internal",
                      "title": "Internal Error",
                      "status": 500,
                      "detail": "Error starting container: Error response from daemon: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: exec: \"storage\": executable file not found in $PATH: unknown"
                    }
                  }
                ],
                "stderr": "",
                "stdout": ""
              },
              "Status": "failed"
            },
            "title": "End: gcp.pipeline.list_storage_buckets"
          }
        ]
      },
      "properties": {
        "category": {
          "color": "green",
          "icon": "valve",
          "name": "pipeline",
          "title": "Pipeline"
        },
        "name": "end_pexec_clnote7e58ci0mg8fspg"
      }
    },
    "execution_tree": {
      "dashboard": "pexec_clnote7e58ci0mg8fspg",
      "name": "execution_tree",
      "panel_type": "graph",
      "status": "complete",
      "title": "Execution",
      "display_type": "graph",
      "data": {
        "columns": [
          {
            "name": "from_id",
            "data_type": "TEXT"
          },
          {
            "name": "to_id",
            "data_type": "TEXT"
          },
          {
            "name": "id",
            "data_type": "TEXT"
          },
          {
            "name": "title",
            "data_type": "TEXT"
          },
          {
            "name": "properties",
            "data_type": "JSONB"
          }
        ],
        "rows": [
          {
            "from_id": "start_pexec_clnote7e58ci0mg8fspg",
            "to_id": "step_container.list_storage_buckets"
          },
          {
            "from_id": "step_container.list_storage_buckets",
            "to_id": "end_pexec_clnote7e58ci0mg8fspg"
          },
          {
            "id": "start_pexec_clnote7e58ci0mg8fspg",
            "properties": {
              "Args": null,
              "Execution ID": "pexec_clnote7e58ci0mg8fspg",
              "Status": "failed"
            },
            "title": "Start: gcp.pipeline.list_storage_buckets"
          },
          {
            "id": "end_pexec_clnote7e58ci0mg8fspg",
            "properties": {
              "Execution ID": "pexec_clnote7e58ci0mg8fspg",
              "Output": {
                "errors": [
                  {
                    "pipeline_execution_id": "pexec_clnote7e58ci0mg8fspg",
                    "step_execution_id": "sexec_clnote7e58ci0mg8fsqg",
                    "pipeline": "gcp.pipeline.list_storage_buckets",
                    "step": "container.list_storage_buckets",
                    "error": {
                      "instance": "fperr_clnote7e58ci0mg8fsr0",
                      "type": "error_internal",
                      "title": "Internal Error",
                      "status": 500,
                      "detail": "Error starting container: Error response from daemon: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: exec: \"storage\": executable file not found in $PATH: unknown"
                    }
                  }
                ],
                "stderr": "",
                "stdout": ""
              },
              "Status": "failed"
            },
            "title": "End: gcp.pipeline.list_storage_buckets"
          },
          {
            "id": "step_container.list_storage_buckets",
            "properties": {
              "Execution ID": "sexec_clnote7e58ci0mg8fsqg",
              "Input": {
                "cmd": [
                  "storage",
                  "buckets",
                  "list",
                  "--format=json"
                ],
                "entrypoint": null,
                "env": {
                  "CLOUDSDK_AUTH_ACCESS_TOKEN": "...",
                  "GCP_PROJECT_ID": "cody-179817"
                },
                "image": "gcr.io/google.com/cloudsdktool/google-cloud-cli",
                "name": "list_storage_buckets"
              },
              "Output": {
                "status": "failed",
                "data": {
                  "container_id": "a4e8fbbf50240375dad0b02e425fce1fda3a169f8cc14e7cca57940953787cb4",
                  "exit_code": -1,
                  "lines": null,
                  "stderr": "",
                  "stdout": ""
                },
                "errors": [
                  {
                    "pipeline_execution_id": "pexec_clnote7e58ci0mg8fspg",
                    "step_execution_id": "sexec_clnote7e58ci0mg8fsqg",
                    "pipeline": "gcp.pipeline.list_storage_buckets",
                    "step": "container.list_storage_buckets",
                    "error": {
                      "instance": "fperr_clnote7e58ci0mg8fsr0",
                      "type": "error_internal",
                      "title": "Internal Error",
                      "status": 500,
                      "detail": "Error starting container: Error response from daemon: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: exec: \"storage\": executable file not found in $PATH: unknown"
                    }
                  }
                ]
              },
              "Status": "failed"
            },
            "title": "0 = "
          }
        ]
      },
      "properties": {
        "direction": "TD",
        "edges": [
          "edge_start_pexec_clnote7e58ci0mg8fspg_to_step_container.list_storage_buckets",
          "edge_step_container.list_storage_buckets_to_end_pexec_clnote7e58ci0mg8fspg"
        ],
        "name": "execution",
        "nodes": [
          "start_pexec_clnote7e58ci0mg8fspg",
          "end_pexec_clnote7e58ci0mg8fspg",
          "step_container.list_storage_buckets"
        ]
      }
    },
    "pexec_clnote7e58ci0mg8fspg": {
      "dashboard": "pexec_clnote7e58ci0mg8fspg",
      "name": "pexec_clnote7e58ci0mg8fspg",
      "panel_type": "dashboard",
      "status": "complete",
      "title": "Pipeline Execution: pexec_clnote7e58ci0mg8fspg",
      "data": {}
    },
    "start_pexec_clnote7e58ci0mg8fspg": {
      "dashboard": "pexec_clnote7e58ci0mg8fspg",
      "name": "start_pexec_clnote7e58ci0mg8fspg",
      "panel_type": "node",
      "status": "complete",
      "title": "Start: gcp.pipeline.list_storage_buckets",
      "data": {
        "columns": [
          {
            "name": "id",
            "data_type": "TEXT"
          },
          {
            "name": "title",
            "data_type": "TEXT"
          },
          {
            "name": "properties",
            "data_type": "JSONB"
          }
        ],
        "rows": [
          {
            "id": "start_pexec_clnote7e58ci0mg8fspg",
            "properties": {
              "Args": null,
              "Execution ID": "pexec_clnote7e58ci0mg8fspg",
              "Status": "failed"
            },
            "title": "Start: gcp.pipeline.list_storage_buckets"
          }
        ]
      },
      "properties": {
        "category": {
          "color": "green",
          "icon": "valve",
          "name": "pipeline",
          "title": "Pipeline"
        },
        "name": "start_pexec_clnote7e58ci0mg8fspg"
      }
    },
    "step_container.list_storage_buckets": {
      "dashboard": "pexec_clnote7e58ci0mg8fspg",
      "name": "step_container.list_storage_buckets",
      "panel_type": "node",
      "status": "complete",
      "title": "container.list_storage_buckets",
      "data": {
        "columns": [
          {
            "name": "id",
            "data_type": "TEXT"
          },
          {
            "name": "title",
            "data_type": "TEXT"
          },
          {
            "name": "properties",
            "data_type": "JSONB"
          }
        ],
        "rows": [
          {
            "id": "step_container.list_storage_buckets",
            "properties": {
              "Execution ID": "sexec_clnote7e58ci0mg8fsqg",
              "Input": {
                "cmd": [
                  "storage",
                  "buckets",
                  "list",
                  "--format=json"
                ],
                "entrypoint": null,
                "env": {
                  "CLOUDSDK_AUTH_ACCESS_TOKEN": "...",
                  "GCP_PROJECT_ID": "cody-179817"
                },
                "image": "gcr.io/google.com/cloudsdktool/google-cloud-cli",
                "name": "list_storage_buckets"
              },
              "Output": {
                "status": "failed",
                "data": {
                  "container_id": "a4e8fbbf50240375dad0b02e425fce1fda3a169f8cc14e7cca57940953787cb4",
                  "exit_code": -1,
                  "lines": null,
                  "stderr": "",
                  "stdout": ""
                },
                "errors": [
                  {
                    "pipeline_execution_id": "pexec_clnote7e58ci0mg8fspg",
                    "step_execution_id": "sexec_clnote7e58ci0mg8fsqg",
                    "pipeline": "gcp.pipeline.list_storage_buckets",
                    "step": "container.list_storage_buckets",
                    "error": {
                      "instance": "fperr_clnote7e58ci0mg8fsr0",
                      "type": "error_internal",
                      "title": "Internal Error",
                      "status": 500,
                      "detail": "Error starting container: Error response from daemon: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: exec: \"storage\": executable file not found in $PATH: unknown"
                    }
                  }
                ]
              },
              "Status": "failed"
            },
            "title": "0 = "
          }
        ]
      },
      "properties": {
        "category": {
          "color": "red",
          "icon": "priority_high",
          "name": "container",
          "title": "container"
        },
        "name": "step_container.list_storage_buckets"
      }
    }
  }
}