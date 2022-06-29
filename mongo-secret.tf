resource "kubernetes_manifest" "secret_mongodb_namespace_mongodb_secret" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "mongo-root-password" = "cGFzc3dvcmQ="
      "mongo-root-username" = "YWRtaW4="
    }
    "kind" = "Secret"
    "metadata" = {
      "name" = "mongodb-secret"
      "namespace" = "mongodb-namespace"
    }
    "type" = "Opaque"
  }
}
