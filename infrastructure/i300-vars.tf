variable "repository_name" {
  type = string
  default = "lawandorga-element-service"
}

variable "certificate_name" {
  type = string
  default = "lawandorga-element-service-certificate"
}

variable "image_name" {
  type = string
  default = "docker.io/vectorim/element-web:v1.11.27"
}