# GKE 

`$ gcloud services enable container.googleapis.com`


> Require terraform 0.13
jq is to interpret json. A script that call from terraform registry from github uses jq.

```
$ sudo apt install git -y
$ sudo apt-get install -y jq
```

>Error: Request "Create IAM Members roles/logging.logWriter serviceAccount:tf-gke-gke-test-1-q2mz@bj-terra-demo.iam.gserviceaccount.com for \"project \\\"bj-terra-demo\\\"\"" returned error: Error retrieving IAM policy for project "bj-terra-demo": googleapi: Error 403: Cloud Resource Manager API has not been used in project 3048724969 before or it is disabled. Enable it by visiting https://console.developers.google.com/apis/api/cloudresourcemanager.googleapis.com/overview?project=3048724969 then retry. If you enabled this API recently, wait a few minutes for the action to propagate to our systems and retry., accessNotConfigured

`$ gcloud services enable cloudresourcemanager.googleapis.com`