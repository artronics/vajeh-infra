include .env

.SILENT:

tf_vars = -var="aws_root_access_key=$(ROOT_AWS_ACCESS_KEY_ID)" -var="aws_root_secret_key=$(ROOT_AWS_SECRET_ACCESS_KEY)"

tf-init:
	terraform -chdir=terraform init
tf-plan:
	terraform -chdir=terraform plan $(tf_vars)
tf-apply:
	terraform -chdir=terraform apply $(tf_vars) -auto-approve
