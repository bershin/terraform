# Advanced Virtual Machine & Firewall Rule

## Advanced
Forward Ips
`can_ip_forward = false`

Describtion
`description = "Advanced seetings in vm"`

Tag
`tags = []`

Size of the disk
```
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
      size = "30"
    }
  }
```

labels (Key-value pair)
```
labels = {
    name         = "test-${count.index+0}"
    machine_type = "${var.environment != "production" ? var.machine_type_prod : var.machine_type}"
}
```
metadata
```
metadata = {
  size  = "20"
  foo   = "bar"
}
```

`metadata_startup_script = "echo hi > /test.txt"`

## Firewall

copy target_tag from firewall to tag in compute
