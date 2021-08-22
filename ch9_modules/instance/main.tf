module "instance" {
  source = "../../ch2_misc"
  machine_type = "n1-standard-4"
}

module "instance_fw" {
  source = "../../ch3_adv_fw"
  machine_type = "n1-standard-4"
}