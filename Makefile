AWS_DIR=stacks/aws
GCP_DIR=stacks/gcp

aws-init:
	cd $(AWS_DIR) && terraform init

aws-apply:
	cd $(AWS_DIR) && terraform apply -auto-approve

aws-destroy:
	cd $(AWS_DIR) && terraform destroy -auto-approve

gcp-init:
	cd $(GCP_DIR) && terraform init

gcp-apply:
	cd $(GCP_DIR) && terraform apply -auto-approve

gcp-destroy:
	cd $(GCP_DIR) && terraform destroy -auto-approve
