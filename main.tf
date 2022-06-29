##################################################################################
# VARIABLES
##################################################################################

##################################################################################
# PROVIDERS
##################################################################################
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = ">= 2.2.0"
    }
 }
}

provider "kubernetes" {
  config_path = "IKS-Cluster01-kubeconfig.yml" # NOTE: Change this value to your kubeconfig file
}

provider "helm" {
  kubernetes {
    config_path = "IKS-Cluster01-kubeconfig.yml"
  }
}



