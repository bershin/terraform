
variable path {
  type        = string
  default     = "/home/bershin/bjgithub"
  description = "Secret"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
provider "google" {
  project     = "bj-terra-demo"
    # https://cloud.google.com/compute/docs/regions-zones
  region      = "europe-west2"
  credentials = "${file("${var.path}/terra_sa.json")}"
}