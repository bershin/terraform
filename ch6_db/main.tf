
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance

resource "google_sql_database_instance" "gcp_database" {
  name                = "${var.name}"
  database_version    = "${var.database_version}"
  region              = "${var.region}"
  deletion_protection = false

  settings {
    tier              = "${var.tier}"
    disk_size         = "${var.disk_size}"
    replication_type  = "${var.replication_type}"
    activation_policy = "${var.activation_policy}"
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user
resource "google_sql_user" "admin" {
  count    = 1
  name     = "${var.user_name}"
  instance = "${google_sql_database_instance.gcp_database.name}"
  host     = "${var.user_host}"
  password = "${var.user_password}"
}

resource "google_sql_user" "dba" {
  count    = 1
  name     = "dba"
  instance = "${google_sql_database_instance.gcp_database.name}"
  host     = "${var.user_host}"
  password = "${var.user_password}"
}