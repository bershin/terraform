# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork


resource "google_compute_network" "custom-test" {
  name                    = "log-test-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subet_1" {
  name          = "log-test-subnetwork1"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.custom-test.id
}

resource "google_compute_subnetwork" "subnet_2" {
  name          = "log-test-subnetwork2"
  ip_cidr_range = "10.3.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.custom-test.id
}


resource "google_compute_subnetwork" "subnet_3" {
  name          = "log-test-subnetwork3"
  ip_cidr_range = "10.4.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.custom-test.id
}
