variable path {
  type        = string
  default     = "/home/bershin/bjgithub"
  description = "Secret"
}

variable "bucket_name" {
  default = "bershin-bucket-storage-gcp"
}

variable "location" {
  default = "europe-west2"
}

variable "storage" {
  default = "REGIONAL"
}

# For coldline
# variable "storage" {
#   default = "COLDLINE"
# }