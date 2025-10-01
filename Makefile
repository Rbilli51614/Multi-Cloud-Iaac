.PHONY: aws-init aws-apply aws-destroy gcp-init gcp-apply gcp-destroy validate apply destroy aws-outputs gcp-outputs

AWS_DIR=stacks/aws
GCP_DIR=stacks/gcp

aws-init:
	cd $(AWS_DIR) && terraform init

aws-apply:
	cd $(AWS_DIR) && terraform apply -auto-approve

aws-destroy:
	cd $(AWS_DIR) && terraform destroy -auto-approve

aws-validate:
	cd $(AWS_DIR) && terraform init -backend=false && terraform validate

aws-outputs:
	cd $(AWS_DIR) && terraform output

gcp-init:
	cd $(GCP_DIR) && terraform init

gcp-apply:
	cd $(GCP_DIR) && terraform apply -auto-approve

gcp-destroy:
	cd $(GCP_DIR) && terraform destroy -auto-approve

gcp-validate:
	cd $(GCP_DIR) && terraform init -backend=false && terraform validate

gcp-outputs:
	cd $(GCP_DIR) && terraform output

# Combined targets
validate: aws-validate gcp-validate
apply: aws-apply gcp-apply
destroy: aws-destroy gcp-destroy
