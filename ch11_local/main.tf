# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance

locals {
  name = "list-${var.name1}-${var.name3}-${var.name2}"
}
resource "google_compute_instance" "default" {
  count   = "${var.machine_count}"
  name         = "${local.name}"
    # https://cloud.google.com/compute/docs/machine-types
    # https://cloud.google.com/compute/docs/general-purpose-machines
  machine_type = "${var.environment != "production" ? var.machine_type_prod : var.machine_type}"
    # https://cloud.google.com/compute/docs/regions-zones
  zone         = "europe-west2-a"

  boot_disk {
    initialize_params {
        # https://cloud.google.com/compute/docs/images/os-details#security-features
        # gcloud compute images list
        # project/family
      image = "${var.image}"
      size  = "20"
    }
  }

  network_interface {
    network = "default"
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  
  can_ip_forward = false

  description = "Advanced setings in vm"

  # For firewall
  tags = ["allow-http", "allow-https"]

  labels = {
    name         = "test-${count.index+0}"
    machine_type = "${var.environment != "production" ? var.machine_type_prod : var.machine_type}"
  }
  
  metadata = {
    size  = "20"
    foo   = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  allow_stopping_for_update = true
}

output "name" {
  value = "${google_compute_instance.default.*.name}"
}
output "machine_type" {
  value = "${google_compute_instance.default.*.machine_type}"
}
output "zone" {
  value = "${google_compute_instance.default.*.zone}"
}

output "join_name" {
  value = "${join(",",google_compute_instance.default.*.id)}"
}