resource "helm_release" "harbor" {
  name       = "harbor"
  repository = "https://helm.goharbor.io"
  chart      = "harbor"
  namespace  = "foundation"
  create_namespace = true

  values = [
    file("${path.module}/values.yaml")
  ]
}
