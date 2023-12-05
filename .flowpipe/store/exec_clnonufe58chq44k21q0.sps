{
  "schema_version": "20221222",
  "start_time": "2023-12-05T20:45:45Z",
  "end_time": "2023-12-05T20:45:45Z",
  "layout": {
    "name": "pexec_clnonufe58chq44k21qg",
    "panel_type": "dashboard",
    "children": [
      {
        "name": "execution_tree",
        "panel_type": "graph"
      }
    ]
  },
  "panels": {
    "edge_start_pexec_clnonufe58chq44k21qg_to_step_container.list_pubsub_topics": {
      "dashboard": "pexec_clnonufe58chq44k21qg",
      "name": "edge_start_pexec_clnonufe58chq44k21qg_to_step_container.list_pubsub_topics",
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
            "from_id": "start_pexec_clnonufe58chq44k21qg",
            "to_id": "step_container.list_pubsub_topics"
          }
        ]
      },
      "properties": {
        "name": "edge_start_pexec_clnonufe58chq44k21qg_to_step_container.list_pubsub_topics"
      }
    },
    "edge_step_container.list_pubsub_topics_to_end_pexec_clnonufe58chq44k21qg": {
      "dashboard": "pexec_clnonufe58chq44k21qg",
      "name": "edge_step_container.list_pubsub_topics_to_end_pexec_clnonufe58chq44k21qg",
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
            "from_id": "step_container.list_pubsub_topics",
            "to_id": "end_pexec_clnonufe58chq44k21qg"
          }
        ]
      },
      "properties": {
        "name": "edge_step_container.list_pubsub_topics_to_end_pexec_clnonufe58chq44k21qg"
      }
    },
    "end_pexec_clnonufe58chq44k21qg": {
      "dashboard": "pexec_clnonufe58chq44k21qg",
      "name": "end_pexec_clnonufe58chq44k21qg",
      "panel_type": "node",
      "status": "complete",
      "title": "End: gcp.pipeline.list_pubsub_topics",
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
            "id": "end_pexec_clnonufe58chq44k21qg",
            "properties": {
              "Execution ID": "pexec_clnonufe58chq44k21qg",
              "Output": {
                "errors": [
                  {
                    "pipeline_execution_id": "pexec_clnonufe58chq44k21qg",
                    "step_execution_id": "",
                    "pipeline": "gcp.pipeline.list_pubsub_topics",
                    "step": "list_pubsub_topics",
                    "error": {
                      "instance": "fperr_clnonufe58chq44k21rg",
                      "type": "error_internal",
                      "title": "Internal Error",
                      "status": 500,
                      "detail": "list_pubsub_topics: Invalid function argument: Invalid value for \"path\" parameter: failed to read file: read .: is a directory.\n(/Users/cbruno/flowpipe/gcp/pipelines/pubsub/list_pubsub_topic.fp:21,24-58)"
                    }
                  }
                ]
              },
              "Status": "failed"
            },
            "title": "End: gcp.pipeline.list_pubsub_topics"
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
        "name": "end_pexec_clnonufe58chq44k21qg"
      }
    },
    "execution_tree": {
      "dashboard": "pexec_clnonufe58chq44k21qg",
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
            "from_id": "start_pexec_clnonufe58chq44k21qg",
            "to_id": "step_container.list_pubsub_topics"
          },
          {
            "from_id": "step_container.list_pubsub_topics",
            "to_id": "end_pexec_clnonufe58chq44k21qg"
          },
          {
            "id": "start_pexec_clnonufe58chq44k21qg",
            "properties": {
              "Args": null,
              "Execution ID": "pexec_clnonufe58chq44k21qg",
              "Status": "failed"
            },
            "title": "Start: gcp.pipeline.list_pubsub_topics"
          },
          {
            "id": "end_pexec_clnonufe58chq44k21qg",
            "properties": {
              "Execution ID": "pexec_clnonufe58chq44k21qg",
              "Output": {
                "errors": [
                  {
                    "pipeline_execution_id": "pexec_clnonufe58chq44k21qg",
                    "step_execution_id": "",
                    "pipeline": "gcp.pipeline.list_pubsub_topics",
                    "step": "list_pubsub_topics",
                    "error": {
                      "instance": "fperr_clnonufe58chq44k21rg",
                      "type": "error_internal",
                      "title": "Internal Error",
                      "status": 500,
                      "detail": "list_pubsub_topics: Invalid function argument: Invalid value for \"path\" parameter: failed to read file: read .: is a directory.\n(/Users/cbruno/flowpipe/gcp/pipelines/pubsub/list_pubsub_topic.fp:21,24-58)"
                    }
                  }
                ]
              },
              "Status": "failed"
            },
            "title": "End: gcp.pipeline.list_pubsub_topics"
          },
          {
            "id": "step_container.list_pubsub_topics",
            "properties": {
              "Status": "Skipped - no executions",
              "Type": "container"
            },
            "title": "container.list_pubsub_topics"
          }
        ]
      },
      "properties": {
        "direction": "TD",
        "edges": [
          "edge_start_pexec_clnonufe58chq44k21qg_to_step_container.list_pubsub_topics",
          "edge_step_container.list_pubsub_topics_to_end_pexec_clnonufe58chq44k21qg"
        ],
        "name": "execution",
        "nodes": [
          "start_pexec_clnonufe58chq44k21qg",
          "end_pexec_clnonufe58chq44k21qg",
          "step_container.list_pubsub_topics"
        ]
      }
    },
    "pexec_clnonufe58chq44k21qg": {
      "dashboard": "pexec_clnonufe58chq44k21qg",
      "name": "pexec_clnonufe58chq44k21qg",
      "panel_type": "dashboard",
      "status": "complete",
      "title": "Pipeline Execution: pexec_clnonufe58chq44k21qg",
      "data": {}
    },
    "start_pexec_clnonufe58chq44k21qg": {
      "dashboard": "pexec_clnonufe58chq44k21qg",
      "name": "start_pexec_clnonufe58chq44k21qg",
      "panel_type": "node",
      "status": "complete",
      "title": "Start: gcp.pipeline.list_pubsub_topics",
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
            "id": "start_pexec_clnonufe58chq44k21qg",
            "properties": {
              "Args": null,
              "Execution ID": "pexec_clnonufe58chq44k21qg",
              "Status": "failed"
            },
            "title": "Start: gcp.pipeline.list_pubsub_topics"
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
        "name": "start_pexec_clnonufe58chq44k21qg"
      }
    },
    "step_container.list_pubsub_topics": {
      "dashboard": "pexec_clnonufe58chq44k21qg",
      "name": "step_container.list_pubsub_topics",
      "panel_type": "node",
      "status": "complete",
      "title": "container.list_pubsub_topics",
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
            "id": "step_container.list_pubsub_topics",
            "properties": {
              "Status": "Skipped - no executions",
              "Type": "container"
            },
            "title": "container.list_pubsub_topics"
          }
        ]
      },
      "properties": {
        "category": {
          "color": "grey",
          "icon": "priority_high",
          "name": "container",
          "title": "container"
        },
        "name": "step_container.list_pubsub_topics"
      }
    }
  }
}