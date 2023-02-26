include .env

.SILENT:
aws_profile = vajeh.root.admin

tf_vars = -var="ptl_aws_access_key_id=$(PTL_AWS_ACCESS_KEY_ID)" \
	-var="ptl_aws_secret_access_key=$(PTL_AWS_SECRET_ACCESS_KEY)"
#	-var="root_aws_access_key_id=$(AWS_ACCESS_KEY_ID)" \
#	-var="root_aws_secret_access_key=$(AWS_SECRET_ACCESS_KEY)"

terraform = AWS_PROFILE=vajeh.root.admin terraform

init:
	$(terraform) init $(tf_vars)

plan:
	$(terraform) plan $(tf_vars)

apply:
	$(terraform) apply $(tf_vars) -auto-approve
