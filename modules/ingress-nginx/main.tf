provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.aks.kube_config[0].host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate)
}

resource "kubernetes_namespace" "ingress" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx-ingress-controller"
    namespace = kubernetes_namespace.ingress.metadata[0].name
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "nginx-ingress"
      }
    }
    template {
      metadata {
        labels = {
          app = "nginx-ingress"
        }
      }
      spec {
        container {
          image = "k8s.gcr.io/ingress-nginx/controller:v0.44.0"
          name  = "controller"
        }
      }
    }
  }
}
