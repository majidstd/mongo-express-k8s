resource "kubernetes_manifest" "deployment_mongodb_namespace_mongodb_deployment" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "mongodb"
      }
      "name" = "mongodb-deployment"
      "namespace" = "mongodb-namespace"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "mongodb"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "mongodb"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "MONGO_INITDB_ROOT_USERNAME"
                  "valueFrom" = {
                    "secretKeyRef" = {
                      "key" = "mongo-root-username"
                      "name" = "mongodb-secret"
                    }
                  }
                },
                {
                  "name" = "MONGO_INITDB_ROOT_PASSWORD"
                  "valueFrom" = {
                    "secretKeyRef" = {
                      "key" = "mongo-root-password"
                      "name" = "mongodb-secret"
                    }
                  }
                },
              ]
              "image" = "mongo"
              "name" = "mongodb"
              "ports" = [
                {
                  "containerPort" = 27017
                },
              ]
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "service_mongodb_namespace_mongodb_service" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "name" = "mongodb-service"
      "namespace" = "mongodb-namespace"
    }
    "spec" = {
      "ports" = [
        {
          "port" = 27017
          "protocol" = "TCP"
          "targetPort" = 27017
        },
      ]
      "selector" = {
        "app" = "mongodb"
      }
    }
  }
}
