terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.74.0"
    }
  }
  required_version = ">= 0.14"
}

data "google_client_config" "current" {}

provider "kubernetes" {
  load_config_file = "false"

  host     = google_container_cluster.primary.endpoint
  username = var.gke_username
  password = var.gke_password

  client_certificate     = base64decode(google_container_cluster.primary.master_auth.0.client_certificate)
  client_key             = base64decode(google_container_cluster.primary.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
