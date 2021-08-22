# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance

resource "google_compute_instance" "default" {
  name         = "test"
    # https://cloud.google.com/compute/docs/machine-types
    # https://cloud.google.com/compute/docs/general-purpose-machines
  machine_type = "n1-standard-1"
    # https://cloud.google.com/compute/docs/regions-zones
  zone         = "europe-west2-a"

  boot_disk {
    initialize_params {
        # https://cloud.google.com/compute/docs/images/os-details#security-features
        # gcloud compute images list
        # project/family
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}