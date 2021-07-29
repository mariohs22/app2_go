# GCP_PROJECT = "app-go-terraform"
# GCP_LOCATION = "us-central1"
# GCP_REGION = "us"
# GCP_SERVICE_NAME = "app-go-service"
# GCP_IMAGE_NAME = "gcr.io/cloudrun/appgo"
# terraform init -reconfigure ${BACKEND_CONFIG} src
# terraform plan ${VARIABLES} -out="plan.out"
# terraform destroy ${VARIABLES} src


#VARIABLES = -var=path=${PWD}/config/resource-groups \

.PHONY = all init plan apply destroy up down

all:

up: init plan apply

down: init destroy

init:
	terraform init -reconfigure

plan:
	terraform plan -out="plan.out"

apply:
	terraform apply plan.out

destroy:
	terraform destroy
