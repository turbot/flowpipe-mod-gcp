{
  "schema_version": "20221222",
  "start_time": "2023-12-05T20:54:58Z",
  "end_time": "2023-12-05T20:54:58Z",
  "layout": {
    "name": "pexec_clnos8ne58chv47s7650",
    "panel_type": "dashboard",
    "children": [
      {
        "name": "execution_tree",
        "panel_type": "graph"
      }
    ]
  },
  "panels": {
    "edge_start_pexec_clnos8ne58chv47s7650_to_step_container.list_storage_buckets": {
      "dashboard": "pexec_clnos8ne58chv47s7650",
      "name": "edge_start_pexec_clnos8ne58chv47s7650_to_step_container.list_storage_buckets",
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
            "from_id": "start_pexec_clnos8ne58chv47s7650",
            "to_id": "step_container.list_storage_buckets"
          }
        ]
      },
      "properties": {
        "name": "edge_start_pexec_clnos8ne58chv47s7650_to_step_container.list_storage_buckets"
      }
    },
    "edge_step_container.list_storage_buckets_to_end_pexec_clnos8ne58chv47s7650": {
      "dashboard": "pexec_clnos8ne58chv47s7650",
      "name": "edge_step_container.list_storage_buckets_to_end_pexec_clnos8ne58chv47s7650",
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
            "to_id": "end_pexec_clnos8ne58chv47s7650"
          }
        ]
      },
      "properties": {
        "name": "edge_step_container.list_storage_buckets_to_end_pexec_clnos8ne58chv47s7650"
      }
    },
    "end_pexec_clnos8ne58chv47s7650": {
      "dashboard": "pexec_clnos8ne58chv47s7650",
      "name": "end_pexec_clnos8ne58chv47s7650",
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
            "id": "end_pexec_clnos8ne58chv47s7650",
            "properties": {
              "Execution ID": "pexec_clnos8ne58chv47s7650",
              "Output": {
                "errors": [
                  {
                    "pipeline_execution_id": "pexec_clnos8ne58chv47s7650",
                    "step_execution_id": "sexec_clnos8ne58chv47s7660",
                    "pipeline": "gcp.pipeline.list_storage_buckets",
                    "step": "container.list_storage_buckets",
                    "error": {
                      "instance": "fperr_clnos8ne58chv47s766g",
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
        "name": "end_pexec_clnos8ne58chv47s7650"
      }
    },
    "execution_tree": {
      "dashboard": "pexec_clnos8ne58chv47s7650",
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
            "from_id": "start_pexec_clnos8ne58chv47s7650",
            "to_id": "step_container.list_storage_buckets"
          },
          {
            "from_id": "step_container.list_storage_buckets",
            "to_id": "end_pexec_clnos8ne58chv47s7650"
          },
          {
            "id": "start_pexec_clnos8ne58chv47s7650",
            "properties": {
              "Args": null,
              "Execution ID": "pexec_clnos8ne58chv47s7650",
              "Status": "failed"
            },
            "title": "Start: gcp.pipeline.list_storage_buckets"
          },
          {
            "id": "end_pexec_clnos8ne58chv47s7650",
            "properties": {
              "Execution ID": "pexec_clnos8ne58chv47s7650",
              "Output": {
                "errors": [
                  {
                    "pipeline_execution_id": "pexec_clnos8ne58chv47s7650",
                    "step_execution_id": "sexec_clnos8ne58chv47s7660",
                    "pipeline": "gcp.pipeline.list_storage_buckets",
                    "step": "container.list_storage_buckets",
                    "error": {
                      "instance": "fperr_clnos8ne58chv47s766g",
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
              "Execution ID": "sexec_clnos8ne58chv47s7660",
              "Input": {
                "cmd": [
                  "storage",
                  "buckets",
                  "list",
                  "--format=json"
                ],
                "entrypoint": null,
                "env": {
                  "CLOUDSDK_AUTH_ACCESS_TOKEN": "ya29.c.c0AY_VpZgkLdnxYNHpPGeDgqHhdYQzbSL1V8GaoBSrB16fIGuY6NKCHSVLPw4w9KXcnjatS-G0ept0tALS7VvV1LO2TLs4Fx3U9baU8bKmzQgkPtKnfh_JtdpsDQsCycdolwlJPAAuL7W0kvAt2jZwC3eMjC5RtcHNlkCBi65iKqaBglbKrznIJL26bHeR9tXWUfXj7CtxEULu_fDUAh-3fkoF4_CRtAtyNuJKKiEsXCXPkhW5J57yXeAx3cAtsgH8H6DL6AqVwK4mqJ2xVTbVMdTAPkUbzn_EPFzkFXohDiuLwrKErL1x9rq4G6vqXWhS91vM4IxHWJ2oy43wkhhlF278PcHIXCAKbQlir74qVnc7COmvmCoeCMlBTfHBZUo-z-RPOwT399DuMo2g4x2b1cbhSj_m6r3crsz7Miyh2l3_twwsp3Mkz8kIyghzlvef87jSIB3vu9JjRm0MImWRx6_rfFJ4IyqUdUeBjXjcXic7afUqsI-9n2Y2hpl-oxmj39gM8eVoMtRa3dfldBilhZ5BXrpX2pjX6Mf_7pb1z13Ruw2eUgkd4B47mX5e4Xu1t8zrwdhIMn7XU1trrMcByepFSIz9_w6clclpOilFf5Ot1XYyM7wcMVuidhO9Mb4f698SMpesshOUdgZrxtblo_Ff8s4dBOyfVYpg-vgZV56kQ1kza6q3kzUbYQWYBaOu-gpMj6fxtWmrYVoFRqdXts4ba10_X8xoY6x7w1-1rcaUuWbag7f3nQeopkv0yn2hdn2Iytf00fez99owBhbp7Fl184mQ96nVk9OnZ4MpV9WwOdM9XxhMSRXvcIb6eiV3kziIs399p-pRwlgU13FiIU_FWXcFc_t7ipsngzarjj2Y4Jw-_algFoW49qiSYJMakYXBw0lUSfBq3-Ya0gQpo9negfw2bdWVjw8ZYg-7Q6xJvdclnj2--gO5r3fZ-zajldkccZ0cjQwvBxkUIt0O8ZJ3Yh4VJ2RdbsWvug6M96dW-8VcnzrMM62",
                  "GCP_PROJECT_ID": "cody-179817"
                },
                "image": "gcr.io/google.com/cloudsdktool/google-cloud-cli",
                "name": "list_storage_buckets"
              },
              "Output": {
                "status": "failed",
                "data": {
                  "container_id": "ec6a6dca8db6b64ed0bc3e472b71cbc9f598989ab060df77a2352bc761c39676",
                  "exit_code": -1,
                  "lines": null,
                  "stderr": "",
                  "stdout": ""
                },
                "errors": [
                  {
                    "pipeline_execution_id": "pexec_clnos8ne58chv47s7650",
                    "step_execution_id": "sexec_clnos8ne58chv47s7660",
                    "pipeline": "gcp.pipeline.list_storage_buckets",
                    "step": "container.list_storage_buckets",
                    "error": {
                      "instance": "fperr_clnos8ne58chv47s766g",
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
          "edge_start_pexec_clnos8ne58chv47s7650_to_step_container.list_storage_buckets",
          "edge_step_container.list_storage_buckets_to_end_pexec_clnos8ne58chv47s7650"
        ],
        "name": "execution",
        "nodes": [
          "start_pexec_clnos8ne58chv47s7650",
          "end_pexec_clnos8ne58chv47s7650",
          "step_container.list_storage_buckets"
        ]
      }
    },
    "pexec_clnos8ne58chv47s7650": {
      "dashboard": "pexec_clnos8ne58chv47s7650",
      "name": "pexec_clnos8ne58chv47s7650",
      "panel_type": "dashboard",
      "status": "complete",
      "title": "Pipeline Execution: pexec_clnos8ne58chv47s7650",
      "data": {}
    },
    "start_pexec_clnos8ne58chv47s7650": {
      "dashboard": "pexec_clnos8ne58chv47s7650",
      "name": "start_pexec_clnos8ne58chv47s7650",
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
            "id": "start_pexec_clnos8ne58chv47s7650",
            "properties": {
              "Args": null,
              "Execution ID": "pexec_clnos8ne58chv47s7650",
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
        "name": "start_pexec_clnos8ne58chv47s7650"
      }
    },
    "step_container.list_storage_buckets": {
      "dashboard": "pexec_clnos8ne58chv47s7650",
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
              "Execution ID": "sexec_clnos8ne58chv47s7660",
              "Input": {
                "cmd": [
                  "storage",
                  "buckets",
                  "list",
                  "--format=json"
                ],
                "entrypoint": null,
                "env": {
                  "CLOUDSDK_AUTH_ACCESS_TOKEN": "ya29.c.c0AY_VpZgkLdnxYNHpPGeDgqHhdYQzbSL1V8GaoBSrB16fIGuY6NKCHSVLPw4w9KXcnjatS-G0ept0tALS7VvV1LO2TLs4Fx3U9baU8bKmzQgkPtKnfh_JtdpsDQsCycdolwlJPAAuL7W0kvAt2jZwC3eMjC5RtcHNlkCBi65iKqaBglbKrznIJL26bHeR9tXWUfXj7CtxEULu_fDUAh-3fkoF4_CRtAtyNuJKKiEsXCXPkhW5J57yXeAx3cAtsgH8H6DL6AqVwK4mqJ2xVTbVMdTAPkUbzn_EPFzkFXohDiuLwrKErL1x9rq4G6vqXWhS91vM4IxHWJ2oy43wkhhlF278PcHIXCAKbQlir74qVnc7COmvmCoeCMlBTfHBZUo-z-RPOwT399DuMo2g4x2b1cbhSj_m6r3crsz7Miyh2l3_twwsp3Mkz8kIyghzlvef87jSIB3vu9JjRm0MImWRx6_rfFJ4IyqUdUeBjXjcXic7afUqsI-9n2Y2hpl-oxmj39gM8eVoMtRa3dfldBilhZ5BXrpX2pjX6Mf_7pb1z13Ruw2eUgkd4B47mX5e4Xu1t8zrwdhIMn7XU1trrMcByepFSIz9_w6clclpOilFf5Ot1XYyM7wcMVuidhO9Mb4f698SMpesshOUdgZrxtblo_Ff8s4dBOyfVYpg-vgZV56kQ1kza6q3kzUbYQWYBaOu-gpMj6fxtWmrYVoFRqdXts4ba10_X8xoY6x7w1-1rcaUuWbag7f3nQeopkv0yn2hdn2Iytf00fez99owBhbp7Fl184mQ96nVk9OnZ4MpV9WwOdM9XxhMSRXvcIb6eiV3kziIs399p-pRwlgU13FiIU_FWXcFc_t7ipsngzarjj2Y4Jw-_algFoW49qiSYJMakYXBw0lUSfBq3-Ya0gQpo9negfw2bdWVjw8ZYg-7Q6xJvdclnj2--gO5r3fZ-zajldkccZ0cjQwvBxkUIt0O8ZJ3Yh4VJ2RdbsWvug6M96dW-8VcnzrMM62",
                  "GCP_PROJECT_ID": "cody-179817"
                },
                "image": "gcr.io/google.com/cloudsdktool/google-cloud-cli",
                "name": "list_storage_buckets"
              },
              "Output": {
                "status": "failed",
                "data": {
                  "container_id": "ec6a6dca8db6b64ed0bc3e472b71cbc9f598989ab060df77a2352bc761c39676",
                  "exit_code": -1,
                  "lines": null,
                  "stderr": "",
                  "stdout": ""
                },
                "errors": [
                  {
                    "pipeline_execution_id": "pexec_clnos8ne58chv47s7650",
                    "step_execution_id": "sexec_clnos8ne58chv47s7660",
                    "pipeline": "gcp.pipeline.list_storage_buckets",
                    "step": "container.list_storage_buckets",
                    "error": {
                      "instance": "fperr_clnos8ne58chv47s766g",
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