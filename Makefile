include .env

.SILENT:

aws_cred := -e AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID) -e AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY) \
	-e aws_root_access_key=$(ROOT_AWS_ACCESS_KEY_ID) -e aws_root_secret_key=$(ROOT_AWS_SECRET_ACCESS_KEY)
tf := docker run --rm -it $(aws_cred) -v $(shell pwd):/app

tf_vars = "-var=\"aws_root_access_key=$(ROOT_AWS_ACCESS_KEY_ID)\" -var=\"aws_root_secret_key=$(ROOT_AWS_SECRET_ACCESS_KEY)\""

ws = ptl
terraform-deploy:
	  $(tf) artronics/terraform-flow --path=/app/terraform --workspace=$(ws) --options="" --dryrun=false --destroy=false --destroy-workspace=false
terraform-destroy:
	  echo $(tf) artronics/terraform-flow --path=/app/terraform --workspace=$(ws) --options=\'$(tf_vars)\' --dryrun=false --destroy=true --destroy-workspace=false

tf-init:
	terraform -chdir=terraform init $(opt)
tf-plan:
	terraform -chdir=terraform plan $(tf_vars)
tf-destroy:
	terraform -chdir=terraform destroy $(tf_vars)
tf-ws:
	terraform -chdir=terraform workspace $(opt)

aws_cred = AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID) AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY)
root_aws_cred = "root_aws_access_key_id:$(ROOT_AWS_ACCESS_KEY_ID) root_aws_secret_access_key:$(ROOT_AWS_SECRET_ACCESS_KEY)"
apply:
	$(aws_cred) vajeh deploy --workspace $(ws) --vars $(root_aws_cred)
plan:
	$(aws_cred) vajeh deploy --dryrun --workspace $(ws) --vars $(root_aws_cred)
destroy:
	$(aws_cred) vajeh deploy --destroy --workspace $(ws) --vars $(root_aws_cred)
