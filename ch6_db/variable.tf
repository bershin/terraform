variable path {
  type        = string
  default     = "/home/bershin/bjgithub"
  description = "Secret"
}

variable "name" {
  default = "gcpdatabase"
}
variable "database_version" {
  default = "MYSQL_5_7"
}
variable "region" {
  default = "europe-west2"
}

variable "tier" {
  default = "db-f1-micro"
}

variable "disk_size" {
  default = "20"
}

variable "replication_type" {
  default = "SYNCHRONOUS"
}

variable "activation_policy" {
  default = "always"
}

variable "user_name" {
  default = "admin"
}

variable "user_host" {
  default = "%"
}

variable "user_password" {
  default = "123456"
}