resource "kubernetes_manifest" "configmap_mongodb_namespace_mongodb_configmap" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "database_url" = "mongodb-service"
    }
    "kind" = "ConfigMap"
    "metadata" = {
      "name" = "mongodb-configmap"
      "namespace" = "mongodb-namespace"
    }
  }
}
