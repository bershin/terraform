# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_template
resource "google_compute_instance_template" "instance_template" {
  count = 1
  name        = "appserver-template"
  description = "This template is used to create app server instances."
  
  # tags = ["foo", "bar"]

  labels = {
    environment = "dev"
    name        = "appserver-template"
  }

  instance_description = "Description assigned to instances"
  machine_type         = "n1-standard-1"
  can_ip_forward       = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  // Create a new boot disk from an image
  disk {
    source_image      = "debian-cloud/debian-9"
    auto_delete       = true
    boot              = true
    // backup the disk every day
    # resource_policies = [google_compute_resource_policy.daily_backup.id]
  }

  // Use an existing disk resource
  # Secondary Volume
  disk {
    // Instance Templates reference disks by name, not self link
    # source        = google_compute_disk.foobar.name
    disk_size_gb  = 10
    auto_delete   = false
    mode          = "READ_WRITE"
    type          = "PERSISTENT"
  }

  network_interface {
    network = "default"
  }

  metadata = {
    foo = "bar"
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    # email  = google_service_account.default.email
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_health_check
resource "google_compute_health_check" "bj-hc" {
  count = 1
  name        = "bj-hc"
  description = "Health check via http"
  
  timeout_sec         = 5
  check_interval_sec  = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10

  http_health_check {
    request_path = "/alive.jsp"
    port = "8080"
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_group_manager
resource "google_compute_instance_group_manager" "inst_grp_mgr" {
  count               = 1
  name                = "appserver-igm"
  base_instance_name  = "app"
  zone        = "europe-west2-a"

  version {
    instance_template = "${google_compute_instance_template.instance_template[0].self_link}"
  }

  auto_healing_policies {
    health_check      = "${google_compute_health_check.bj-hc[0].self_link}"
    initial_delay_sec = 300
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_autoscaler
resource "google_compute_autoscaler" "auto_scaler" {
  count       = 1
  project     = "bj-terra-demo"
  name        = "my-autoscaler"
  zone        = "europe-west2-a"
  target      = "${google_compute_instance_group_manager.inst_grp_mgr[0].self_link}"

  autoscaling_policy {
    max_replicas    = 2
    min_replicas    = 1
    cooldown_period = 60
    cpu_utilization {
      target = "0.8" #80%
    }
  }
}