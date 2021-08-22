
variable path {
  type        = string
  default     = "/home/bershin/bjgithub"
  description = "Secret"
}

variable "image" {
  default = "debian-cloud/debian-9"
}

variable "name1" {
  default = "name-1"
}

variable "name2" {
  default = "name-2"
}

variable "name3" {
  default = "name-3"
}
variable "machine_type" {
  default = "n1-standard-1"
}

variable "machine_type_prod" {
  default = "n1-standard-2"
}

variable "environment" {
  default = "production"
}

variable "list_array" {
  default = ["server1", "server2", "server3"]
}

variable "machine_count" {
  default = "1"
}