provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "nginx_ingress" {
  name       = "goat-nginx-ingress-controller"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}

resource "helm_release" "nginx" {
  name       = "goat-nginx"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"
}