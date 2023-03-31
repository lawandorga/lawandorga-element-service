resource "kubernetes_config_map_v1" "config" {
  metadata {
    name = "${var.repository_name}"
  }

  data = {
    "config.json" = "${file("${path.module}/../src/config.json")}"
  }
}