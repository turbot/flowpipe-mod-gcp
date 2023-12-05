{
  "schema_version": "20221222",
  "start_time": "2023-12-05T20:50:26Z",
  "end_time": "2023-12-05T20:50:26Z",
  "layout": {
    "name": "pexec_clnoq0ne58chsfqb96r0",
    "panel_type": "dashboard",
    "children": [
      {
        "name": "execution_tree",
        "panel_type": "graph"
      }
    ]
  },
  "panels": {
    "edge_start_pexec_clnoq0ne58chsfqb96r0_to_step_container.list_pubsub_topics": {
      "dashboard": "pexec_clnoq0ne58chsfqb96r0",
      "name": "edge_start_pexec_clnoq0ne58chsfqb96r0_to_step_container.list_pubsub_topics",
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
            "from_id": "start_pexec_clnoq0ne58chsfqb96r0",
            "to_id": "step_container.list_pubsub_topics"
          }
        ]
      },
      "properties": {
        "name": "edge_start_pexec_clnoq0ne58chsfqb96r0_to_step_container.list_pubsub_topics"
      }
    },
    "edge_step_container.list_pubsub_topics_to_end_pexec_clnoq0ne58chsfqb96r0": {
      "dashboard": "pexec_clnoq0ne58chsfqb96r0",
      "name": "edge_step_container.list_pubsub_topics_to_end_pexec_clnoq0ne58chsfqb96r0",
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
            "to_id": "end_pexec_clnoq0ne58chsfqb96r0"
          }
        ]
      },
      "properties": {
        "name": "edge_step_container.list_pubsub_topics_to_end_pexec_clnoq0ne58chsfqb96r0"
      }
    },
    "end_pexec_clnoq0ne58chsfqb96r0": {
      "dashboard": "pexec_clnoq0ne58chsfqb96r0",
      "name": "end_pexec_clnoq0ne58chsfqb96r0",
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
            "id": "end_pexec_clnoq0ne58chsfqb96r0",
            "properties": {
              "Execution ID": "pexec_clnoq0ne58chsfqb96r0",
              "Output": {
                "stderr": "",
                "stdout": "[\n  {\n    \"name\": \"projects/cody-179817/topics/testing\"\n  },\n  {\n    \"name\": \"projects/cody-179817/topics/testtopic123\"\n  },\n  {\n    \"name\": \"projects/cody-179817/topics/testtopic1234\"\n  }\n]\n"
              },
              "Status": "finished"
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
        "name": "end_pexec_clnoq0ne58chsfqb96r0"
      }
    },
    "execution_tree": {
      "dashboard": "pexec_clnoq0ne58chsfqb96r0",
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
            "from_id": "start_pexec_clnoq0ne58chsfqb96r0",
            "to_id": "step_container.list_pubsub_topics"
          },
          {
            "from_id": "step_container.list_pubsub_topics",
            "to_id": "end_pexec_clnoq0ne58chsfqb96r0"
          },
          {
            "id": "start_pexec_clnoq0ne58chsfqb96r0",
            "properties": {
              "Args": null,
              "Execution ID": "pexec_clnoq0ne58chsfqb96r0",
              "Status": "finished"
            },
            "title": "Start: gcp.pipeline.list_pubsub_topics"
          },
          {
            "id": "end_pexec_clnoq0ne58chsfqb96r0",
            "properties": {
              "Execution ID": "pexec_clnoq0ne58chsfqb96r0",
              "Output": {
                "stderr": "",
                "stdout": "[\n  {\n    \"name\": \"projects/cody-179817/topics/testing\"\n  },\n  {\n    \"name\": \"projects/cody-179817/topics/testtopic123\"\n  },\n  {\n    \"name\": \"projects/cody-179817/topics/testtopic1234\"\n  }\n]\n"
              },
              "Status": "finished"
            },
            "title": "End: gcp.pipeline.list_pubsub_topics"
          },
          {
            "id": "step_container.list_pubsub_topics",
            "properties": {
              "Execution ID": "sexec_clnoq0ne58chsfqb96s0",
              "Input": {
                "cmd": [
                  "pubsub",
                  "topics",
                  "list"
                ],
                "entrypoint": null,
                "env": {
                  "GCP_CREDS": "{\n  \"type\": \"service_account\",\n  \"project_id\": \"cody-179817\",\n  \"private_key_id\": \"<redacted>\",\n  \"private_key\": \"-----BEGIN PRIVATE KEY-----\\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCjw2UtE+iDAB2o\\nkBagV5NFKdwP2BC58gUWPAdRWshkKm6lYydYOarKmZ1Dj8stT6seLUPEUeOFjp0T\\nAdseu65dzuVTJ3WrVYNvGmMnx2zXeyJCVS3HQ2zMkfFh9HVIlkJtCSytGSedp3+L\\nmyN3UrqucPg2RxdOCpWpYo/PSVkC5BahugrHyzZU9AP6dv3fNvJrALasp+oYypgW\\nFdTP7xKuD5sp92yrbCP3D7Ber4bPUDL+/FAJjVKTojVuZIcymr27gQKJvbnSmame\\nxighn2PIKkDTb0gw+CL0vTMZp3LY8HlDLNJ3Pz28hSA1vfA4haSZfEGK8kfY4IYH\\nfNLaSLTnAgMBAAECggEAM4cOtcFW3qlRq7EyvV7w4slKCd41XRyuxxE6SDnlZccI\\nK5foUFVMzRTKq/B5wJcZw5QAh6wwh9yYxdtGpAPv2Gp6M9DtsGxmv7Wwz1prf92p\\nqO9+SP2JJVEif2zY3m8RFZfWa9zHX07NzhKRdUEdpje7kfCKf67K6pItp85vaH30\\nnkCxna1+FNYr1OnGqi36sgKrf8CF46SichLYoOmznmPNnBq0jbVrlG+f0IGxPcWB\\nqsGDROWSPc94UxYOvbsqyFJFKwKsAtbLKKkFGiZWu0VVEIDWEZws34vFpjMhdRM2\\nB0SBt2gGEWLOHOLBESDRynXVvV+Qfc9EayfCBJBo+QKBgQDj3sHhwMSgz+8aFtoz\\n67GocGlzOWXXvfmcK+GLz9uLQ8s0dp0dWK/YofFSl8Go3qOBqC7k2k7ctxkstqJy\\n5dXeF3ClwntJ5jMmHvkNmYu7xO9YuGXGW+B4JjM/3ImVsbdHL/IvldpaOh1BK8nJ\\npyw4JJmeblWce0edI/iAYViN4wKBgQC3+rTswBNJgFkjTiV6Yxgt4ooV2K88stqK\\nyO3/b05t5vDp2UzRy3RpGrSqeO9PZzYtnh8kqjlrGxIjcHtICKoAjuJSwaAUaNvI\\nBZPzOZyKVZZZEUSkkzr316fRLHJZWHnZZGaoiuSUI2Ly6xryV1/3lS4dcSOEh0BE\\nZBeLPXRsLQKBgGd4nDNltCONp/YB0H1pFhf1S3zd4GfxxOlsZ5N0BC4dz6T4A2ny\\n/o5xIsKtVGvZBQf4Fasnkk3Y+p56JBPmV5HstOMgB5nL5Qf3YoIRagkOaNyxhs1m\\npOwJ9JWYEAWgWCgEFoYTFr6Hywbv2kYuGf84Z2UwlsFinWc2kT3CdlKfAoGANwIb\\n1Gm9mo1omXjFFenJEfcZCF0oUAK9+x8GoggasBuLzq+tG1E0tjRI7muISfp3JX6Q\\nmzrWPiLy8muwQKJuigouu0WvYkrT4+NfECsalfXvJSRXnMl0qSPuxkj+y537mLc/\\nRod4vp4x+KW5AdqEFBejmSP51adG3Ov8aiJuy+UCgYEAtRLxy/TKkmpzLfT6WKmQ\\nUfMzixMHe0XBUnnoHBqXzM41CqddrzfpBraev4sG//qScL6tw0+Kl2BnSDJ3OuXk\\nf6uRlxwuqfrRk5AohwscOhFNyfd/2Cp6MnNtoRot/QllnJCvQea5eFN90L+6lNBd\\nvQljZrFTA+fy3Q85WNk8R0g=\\n-----END PRIVATE KEY-----\\n\",\n  \"client_email\": \"turbot-superuser@cody-179817.iam.gserviceaccount.com\",\n  \"client_id\": \"109021161562161761069\",\n  \"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\",\n  \"token_uri\": \"https://oauth2.googleapis.com/token\",\n  \"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\",\n  \"client_x509_cert_url\": \"https://www.googleapis.com/robot/v1/metadata/x509/turbot-superuser%40cody-179817.iam.gserviceaccount.com\"\n}\n",
                  "GCP_PROJECT_ID": "cody-179817"
                },
                "image": "my-gcloud-image-latest",
                "name": "list_pubsub_topics"
              },
              "Output": {
                "status": "finished",
                "data": {
                  "container_id": "<redacted>bad2ec4da6431e4f27bf4fca",
                  "exit_code": 0,
                  "lines": [
                    {
                      "line": "[\n",
                      "stream": "stdout"
                    },
                    {
                      "line": "  {\n",
                      "stream": "stdout"
                    },
                    {
                      "line": "    \"name\": \"projects/cody-179817/topics/testing\"\n",
                      "stream": "stdout"
                    },
                    {
                      "line": "  },\n",
                      "stream": "stdout"
                    },
                    {
                      "line": "  {\n",
                      "stream": "stdout"
                    },
                    {
                      "line": "    \"name\": \"projects/cody-179817/topics/testtopic123\"\n",
                      "stream": "stdout"
                    },
                    {
                      "line": "  },\n",
                      "stream": "stdout"
                    },
                    {
                      "line": "  {\n",
                      "stream": "stdout"
                    },
                    {
                      "line": "    \"name\": \"projects/cody-179817/topics/testtopic1234\"\n",
                      "stream": "stdout"
                    },
                    {
                      "line": "  }\n",
                      "stream": "stdout"
                    },
                    {
                      "line": "]\n",
                      "stream": "stdout"
                    }
                  ],
                  "stderr": "",
                  "stdout": "[\n  {\n    \"name\": \"projects/cody-179817/topics/testing\"\n  },\n  {\n    \"name\": \"projects/cody-179817/topics/testtopic123\"\n  },\n  {\n    \"name\": \"projects/cody-179817/topics/testtopic1234\"\n  }\n]\n"
                }
              },
              "Status": "finished"
            },
            "title": "0 = "
          }
        ]
      },
      "properties": {
        "direction": "TD",
        "edges": [
          "edge_start_pexec_clnoq0ne58chsfqb96r0_to_step_container.list_pubsub_topics",
          "edge_step_container.list_pubsub_topics_to_end_pexec_clnoq0ne58chsfqb96r0"
        ],
        "name": "execution",
        "nodes": [
          "start_pexec_clnoq0ne58chsfqb96r0",
          "end_pexec_clnoq0ne58chsfqb96r0",
          "step_container.list_pubsub_topics"
        ]
      }
    },
    "pexec_clnoq0ne58chsfqb96r0": {
      "dashboard": "pexec_clnoq0ne58chsfqb96r0",
      "name": "pexec_clnoq0ne58chsfqb96r0",
      "panel_type": "dashboard",
      "status": "complete",
      "title": "Pipeline Execution: pexec_clnoq0ne58chsfqb96r0",
      "data": {}
    },
    "start_pexec_clnoq0ne58chsfqb96r0": {
      "dashboard": "pexec_clnoq0ne58chsfqb96r0",
      "name": "start_pexec_clnoq0ne58chsfqb96r0",
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
            "id": "start_pexec_clnoq0ne58chsfqb96r0",
            "properties": {
              "Args": null,
              "Execution ID": "pexec_clnoq0ne58chsfqb96r0",
              "Status": "finished"
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
        "name": "start_pexec_clnoq0ne58chsfqb96r0"
      }
    },
    "step_container.list_pubsub_topics": {
      "dashboard": "pexec_clnoq0ne58chsfqb96r0",
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
              "Execution ID": "sexec_clnoq0ne58chsfqb96s0",
              "Input": {
                "cmd": [
                  "pubsub",
                  "topics",
                  "list"
                ],
                "entrypoint": null,
                "env": {
                  "GCP_CREDS": "{\n  \"type\": \"service_account\",\n  \"project_id\": \"cody-179817\",\n  \"private_key_id\": \"<redacted>\",\n  \"private_key\": \"-----BEGIN PRIVATE KEY-----\\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCjw2UtE+iDAB2o\\nkBagV5NFKdwP2BC58gUWPAdRWshkKm6lYydYOarKmZ1Dj8stT6seLUPEUeOFjp0T\\nAdseu65dzuVTJ3WrVYNvGmMnx2zXeyJCVS3HQ2zMkfFh9HVIlkJtCSytGSedp3+L\\nmyN3UrqucPg2RxdOCpWpYo/PSVkC5BahugrHyzZU9AP6dv3fNvJrALasp+oYypgW\\nFdTP7xKuD5sp92yrbCP3D7Ber4bPUDL+/FAJjVKTojVuZIcymr27gQKJvbnSmame\\nxighn2PIKkDTb0gw+CL0vTMZp3LY8HlDLNJ3Pz28hSA1vfA4haSZfEGK8kfY4IYH\\nfNLaSLTnAgMBAAECggEAM4cOtcFW3qlRq7EyvV7w4slKCd41XRyuxxE6SDnlZccI\\nK5foUFVMzRTKq/B5wJcZw5QAh6wwh9yYxdtGpAPv2Gp6M9DtsGxmv7Wwz1prf92p\\nqO9+SP2JJVEif2zY3m8RFZfWa9zHX07NzhKRdUEdpje7kfCKf67K6pItp85vaH30\\nnkCxna1+FNYr1OnGqi36sgKrf8CF46SichLYoOmznmPNnBq0jbVrlG+f0IGxPcWB\\nqsGDROWSPc94UxYOvbsqyFJFKwKsAtbLKKkFGiZWu0VVEIDWEZws34vFpjMhdRM2\\nB0SBt2gGEWLOHOLBESDRynXVvV+Qfc9EayfCBJBo+QKBgQDj3sHhwMSgz+8aFtoz\\n67GocGlzOWXXvfmcK+GLz9uLQ8s0dp0dWK/YofFSl8Go3qOBqC7k2k7ctxkstqJy\\n5dXeF3ClwntJ5jMmHvkNmYu7xO9YuGXGW+B4JjM/3ImVsbdHL/IvldpaOh1BK8nJ\\npyw4JJmeblWce0edI/iAYViN4wKBgQC3+rTswBNJgFkjTiV6Yxgt4ooV2K88stqK\\nyO3/b05t5vDp2UzRy3RpGrSqeO9PZzYtnh8kqjlrGxIjcHtICKoAjuJSwaAUaNvI\\nBZPzOZyKVZZZEUSkkzr316fRLHJZWHnZZGaoiuSUI2Ly6xryV1/3lS4dcSOEh0BE\\nZBeLPXRsLQKBgGd4nDNltCONp/YB0H1pFhf1S3zd4GfxxOlsZ5N0BC4dz6T4A2ny\\n/o5xIsKtVGvZBQf4Fasnkk3Y+p56JBPmV5HstOMgB5nL5Qf3YoIRagkOaNyxhs1m\\npOwJ9JWYEAWgWCgEFoYTFr6Hywbv2kYuGf84Z2UwlsFinWc2kT3CdlKfAoGANwIb\\n1Gm9mo1omXjFFenJEfcZCF0oUAK9+x8GoggasBuLzq+tG1E0tjRI7muISfp3JX6Q\\nmzrWPiLy8muwQKJuigouu0WvYkrT4+NfECsalfXvJSRXnMl0qSPuxkj+y537mLc/\\nRod4vp4x+KW5AdqEFBejmSP51adG3Ov8aiJuy+UCgYEAtRLxy/TKkmpzLfT6WKmQ\\nUfMzixMHe0XBUnnoHBqXzM41CqddrzfpBraev4sG//qScL6tw0+Kl2BnSDJ3OuXk\\nf6uRlxwuqfrRk5AohwscOhFNyfd/2Cp6MnNtoRot/QllnJCvQea5eFN90L+6lNBd\\nvQljZrFTA+fy3Q85WNk8R0g=\\n-----END PRIVATE KEY-----\\n\",\n  \"client_email\": \"turbot-superuser@cody-179817.iam.gserviceaccount.com\",\n  \"client_id\": \"109021161562161761069\",\n  \"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\",\n  \"token_uri\": \"https://oauth2.googleapis.com/token\",\n  \"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\",\n  \"client_x509_cert_url\": \"https://www.googleapis.com/robot/v1/metadata/x509/turbot-superuser%40cody-179817.iam.gserviceaccount.com\"\n}\n",
                  "GCP_PROJECT_ID": "cody-179817"
                },
                "image": "my-gcloud-image-latest",
                "name": "list_pubsub_topics"
              },
              "Output": {
                "status": "finished",
                "data": {
                  "container_id": "<redacted>bad2ec4da6431e4f27bf4fca",
                  "exit_code": 0,
                  "lines": [
                    {
                      "line": "[\n",
                      "stream": "stdout"
                    },
                    {
                      "line": "  {\n",
                      "stream": "stdout"
                    },
                    {
                      "line": "    \"name\": \"projects/cody-179817/topics/testing\"\n",
                      "stream": "stdout"
                    },
                    {
                      "line": "  },\n",
                      "stream": "stdout"
                    },
                    {
                      "line": "  {\n",
                      "stream": "stdout"
                    },
                    {
                      "line": "    \"name\": \"projects/cody-179817/topics/testtopic123\"\n",
                      "stream": "stdout"
                    },
                    {
                      "line": "  },\n",
                      "stream": "stdout"
                    },
                    {
                      "line": "  {\n",
                      "stream": "stdout"
                    },
                    {
                      "line": "    \"name\": \"projects/cody-179817/topics/testtopic1234\"\n",
                      "stream": "stdout"
                    },
                    {
                      "line": "  }\n",
                      "stream": "stdout"
                    },
                    {
                      "line": "]\n",
                      "stream": "stdout"
                    }
                  ],
                  "stderr": "",
                  "stdout": "[\n  {\n    \"name\": \"projects/cody-179817/topics/testing\"\n  },\n  {\n    \"name\": \"projects/cody-179817/topics/testtopic123\"\n  },\n  {\n    \"name\": \"projects/cody-179817/topics/testtopic1234\"\n  }\n]\n"
                }
              },
              "Status": "finished"
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
        "name": "step_container.list_pubsub_topics"
      }
    }
  }
}