resource "kubernetes_manifest" "deployment_mongodb_namespace_mongodb_express_deployment" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "mongodb-express"
      }
      "name" = "mongodb-express-deployment"
      "namespace" = "mongodb-namespace"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "mongodb-express"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "mongodb-express"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "ME_CONFIG_MONGODB_ADMINUSERNAME"
                  "valueFrom" = {
                    "secretKeyRef" = {
                      "key" = "mongo-root-username"
                      "name" = "mongodb-secret"
                    }
                  }
                },
                {
                  "name" = "ME_CONFIG_MONGODB_ADMINPASSWORD"
                  "valueFrom" = {
                    "secretKeyRef" = {
                      "key" = "mongo-root-password"
                      "name" = "mongodb-secret"
                    }
                  }
                },
                {
                  "name" = "ME_CONFIG_MONGODB_SERVER"
                  "valueFrom" = {
                    "configMapKeyRef" = {
                      "key" = "database_url"
                      "name" = "mongodb-configmap"
                    }
                  }
                },
              ]
              "image" = "mongo-express"
              "name" = "mongodb-express"
              "ports" = [
                {
                  "containerPort" = 8081
                },
              ]
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "service_mongodb_namespace_mongodb_express_service" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "name" = "mongodb-express-service"
      "namespace" = "mongodb-namespace"
    }
    "spec" = {
      "ports" = [
        {
          "nodePort" = 30000
          "port" = 8081
          "protocol" = "TCP"
          "targetPort" = 8081
        },
      ]
      "selector" = {
        "app" = "mongodb-express"
      }
      "type" = "LoadBalancer"
    }
  }
}
