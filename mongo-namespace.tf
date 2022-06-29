resource "kubernetes_manifest" "namespace_mongodb_namespace" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Namespace"
    "metadata" = {
      "name" = "mongodb-namespace"
    }
  }
}
