
# First instance
## Manual
Create a folder first_instance and write two files main.tf and provider.tf.
### Initialize the terraform workspace
Execute the init command after main.tf and provider.tf is ready

`$ terraform init chapter_1/`
>Create a folder in 'pwd' .terraform/plugins/linux_amd64/ with 
Terraform provider for google and 
lock.json
linux_amd64 - since we initiate in a linux machine 64bit

### Calculate the plan

`$ terraform plan chapter_1/`

> Look if there is anything in add, change or destroy more than '0'
> Also creates a terraform.tfstate file in 'pwd'

### Apply the changes

`$ terraform apply chapter_1/`

> Look if there is anything in added, changed or destroyed more than '0'
> Verify the vm has been created 
> `$ gcloud compute instances list`
> Also see the details created as per intruction
> `$ gcloud compute instances describe test`
> Look for update

### Destroy the vm created using terraform
`$ terraform destroy chapter_1/`

> Verify the vm has been destroyed 
> `$ gcloud compute instances list`
> Check terraform.tfstate file is backuped as terraform.tfstate.backup file and terraform.tfstate file is updated with the removed information.

## Automate
Copy plan.sh, apply.sh and destroy.sh inside 'terraform' folder and change permission.
`$ chmod +x *.sh`

### Calculate the plan

`$ ./plan.sh chapter_1/`

### Apply the changes

`$ ./apply.sh chapter_1/`

> Note the 'auto-approve' will not prompt to approve

### Destroy the vm created using terraform
`$ ./destroy.sh chapter_1/`

> Show status as how many "destroyed"
> Verify the vm has been destroyed 
> `$ gcloud compute instances list`

## Troubleshooting:
###Error:1
Error: Error loading zone 'europe-west2-a': googleapi: Error 403: Compute Engine API has not been used in project 553516262799 before or it is disabled. Enable it by visiting https://console.developers.google.com/apis/api/compute.googleapis.com/overview?project=553516262799 then retry. If you enabled this API recently, wait a few minutes for the action to propagate to our systems and retry., accessNotConfigured

Check the project number matches with the one we created.
`$ gcloud projects list`
