tf-init:
	terraform -chdir=terraform init
tf-apply:
	terraform -chdir=terraform apply -auto-approve
