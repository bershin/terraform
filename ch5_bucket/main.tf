# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
resource "google_storage_bucket" "static-site" {
  count         = 1
  name          = "${var.bucket_name}"
  location      = "${var.location}"
  storage_class = "${var.storage}"
  force_destroy = true

  labels = {
    name          = "bershin-bucket-storage-gcp"
    location      = "europe-west2"
  }

  versioning {
    enabled = true
  }
}
