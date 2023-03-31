resource "kubernetes_deployment_v1" "deployment" {
  metadata {
    name = var.repository_name
    labels = {
      app = "${var.repository_name}"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "${var.repository_name}"
      }
    }

    template {
      metadata {
        labels = {
          app = "${var.repository_name}"
        }
      }

      spec {
        volume {
          name = "config-volume"
          config_map {
            name = kubernetes_config_map_v1.config.metadata.0.name
          }
        }

        container {
          image = "${var.image_name}"
          name  = "${var.repository_name}-container"

          volume_mount {
            name       = "config-volume"
            mount_path = "/app/config.json"
            sub_path   = "config.json"
            read_only  = true
          }

          port {
            container_port = 80
          }

          readiness_probe {
            http_get {
              port = 80
              http_header {
                name  = "Host"
                value = "chat.law-orga.de"
              }
            }
          }
        }
      }
    }
  }
}
