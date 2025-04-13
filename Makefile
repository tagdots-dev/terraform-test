# Makefile

NEW_DASH="-------------------------------------------------"
NEW_LINE="\\n"

SHELL := /bin/sh
usage:
	@echo "Usage:"
	@echo "\tmake ws=<workspace name> tf-setup"
	@echo "\tmake ws=<workspace name> tf-apply"
	@echo "\tmake ws=<workspace name> tf-fmt"
	@echo "\tmake ws=<workspace name> tf-init"
	@echo "\tmake ws=<workspace name> tf-plan"
	@echo "\tmake ws=<workspace name> tf-validate"

tf-apply:
	@echo "${NEW_DASH}${NEW_LINE}Apply Terraform...${NEW_LINE}${NEW_DASH}"
	terraform -chdir=workspace/$(ws) apply -backup=state-backup/terraform.tfstate.backup plans/${ws}.plan

tf-fmt:
	@echo "${NEW_DASH}${NEW_LINE}Fix Terraform Format...${NEW_LINE}${NEW_DASH}"
	terraform -chdir=workspace/$(ws) fmt -recursive -diff .

tf-init:
	@echo "${NEW_DASH}${NEW_LINE}Initialize Terraform...${NEW_LINE}${NEW_DASH}"
	terraform -chdir=workspace/$(ws) init -upgrade

tf-plan:
	@echo "${NEW_DASH}${NEW_LINE}Make Terraform Plan...${NEW_LINE}${NEW_DASH}"
	terraform -chdir=workspace/$(ws) plan -out=plans/${ws}.plan

tf-setup:
	@echo "${NEW_DASH}${NEW_LINE}Setup new workspace and virtualenv...${NEW_LINE}${NEW_DASH}"
	mkdir -p workspace/${ws}/{plans,secrets,state-backup}
	touch workspace/${ws}/plans/${ws}.plan
	touch workspace/${ws}/secrets/${ws}.secrets
	touch workspace/${ws}/terraform.tfvars

tf-validate:
	@echo "${NEW_DASH}${NEW_LINE}Validate Terraform Configurations...${NEW_LINE}${NEW_DASH}"
	terraform -chdir=workspace/$(ws) validate

.PHONY: help tf-apply tf-fmt tf-init tf-plan tf-setup tf-validate
