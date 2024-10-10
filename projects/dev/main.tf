terraform {
    backend "local" {
        path = "/srv/atlantis/terraform.tfstate"
    }
}

module "gke" {
    source = "../../modules/gcp/gke"
    project_id = var.project_id
    region = var.region
    zone = var.zone
}

module "harbor" {
    source = "../../modules/infra/harbor"
    depends_on = [module.gke]
}
