# Additionals
## Variables
### Same file
In main.tf file update the variables in the top of the file and substitute the value
```
variable "key" { default = "value"}
name = "${var.key}"
```
or)
`name = var.key`
Apply and check
```
./plan.sh chapter_2
./apply.sh chapter_2
./destroy.sh chapter_2
```

### Different file
Move the variables session into a seperate file called variable.tf
> File name doesn`t matter
> 
Apply and check
```
./plan.sh chapter_2
./apply.sh chapter_2
./destroy.sh chapter_2
```
## Output
At the bottom of the main.tf file.
```
output "display_output" { value = "${resource.its_name.its_field}"}
```
> The output value will be shown, when you apply
> Output is displayed in alphabetic order based on name
## List, Count & Length
Declare a list/array
`variable "key_count" { default = ["value1", "value2", "value3"]}`

Loop through the list to create within resource
`count = "${length(var.key_count)}"`
`name = "list-${count.index+1}"`
>Above two line should come within a resource session.
>The variable 'count' cannot be any other name.

output all list in array(*.)
`output "display_output" { value = "${resource.its_name.*.its_field}"}`

> apply shows three in output and creates three resources.
## Maps
Map key to a value and use as a variable.
```
variable "machine_type" {
  type = map
  default = {
      dev   = "n1-standard-1"
      prod  = "wont work"
  }
}
```
>Best practice for devops

`machine_type = "${var.machine_type["dev"]}"`
>dev can be changed to prod to apply prod value
## Join
Join the output with comma and display in a single line instead of each line.
```
output "join_name" {
  value = "${join(",",google_compute_instance.default.*.id)}"
}
```
>join("delimit","resource.its_name.*.its_field")
## Depends On
Create two instance resource and paste 'depends_on' inside anyone of the resource
`depends_on = [google_compute_instance.default]`

To avoid resource naming created twice change
`count   = "${length(var.list_array)}"`
to
```
count = 1
name         = "test-${count.index+0}"
```
Second resource
```
count = 1
name         = "test-${count.index+1}"
```
## Conditionals (IF Statements)

CONDITION ? TRUE : FALSE
```
variable "machine_type" {
  default = "n1-standard-1"
}

variable "machine_type_prod" {
  default = "n1-standard-2"
}

variable "environment" {
  default = "production"
}
```
`machine_type = "${var.environment == "production" ? var.machine_type_prod : var.machine_type}"`
> '!=' for not equal to

## Troubleshooting
Error: Changing the machine_type, min_cpu_platform, service_account, enable_display, shielded_instance_config, or network_interface.[#d].(network/subnetwork/subnetwork_project) on a started instance requires stopping it. To acknowledge this, please set allow_stopping_for_update = true in your config. You can also stop it by setting desired_status = "TERMINATED", but the instance will not be restarted after the update.

```
  allow_stopping_for_update = true
```
>Add above line in end of the compute resource file.