# NOTE: source .env file before running targets
BUILDDIR = build

tf = TF_VAR_project=vajeh-infra TF_VAR_account_zone=ptl terraform -chdir=terraform

init:
	$(tf) init

plan:
	$(tf) plan

apply:
	$(tf) apply -auto-approve

lock-provider:
	invoke lock-provider

clean:
	rm -rf build terraform/.terraform terraform/out

$(BUILDDIR):
	mkdir $(BUILDDIR)
