# GCP_PROJECT = "app-go-terraform"
# GCP_LOCATION = "us-central1"
# GCP_REGION = "us"
# GCP_SERVICE_NAME = "app-go-service"
# GCP_IMAGE_NAME = "gcr.io/cloudrun/appgo"


BACKEND_CONFIG =    -backend-config=project='$${{ secrets.GCP_PROJECT }}' \
                    -backend-config=location='$${{ secrets.GCP_LOCATION }}' \
                    -backend-config=gcr_region='$${{ secrets.GCP_REGION }}' \
					-backend-config=service_name='$${{ secrets.GCP_SERVICE_NAME }}' \
					-backend-config=image_name='$${{ secrets.GCP_IMAGE_NAME }}'
#                    -backend-config=key='$${{ secrets.AZURE_TERRAFORM_RESOURCE_GROUP_NAME }}.tfstate'

# VARIABLES = -var=path=${PWD}/config/resource-groups \

all:

up: init plan apply

down: init destroy

init:
# terraform init -reconfigure ${BACKEND_CONFIG} src
    terraform init -reconfigure ${BACKEND_CONFIG}

plan:
# terraform plan ${VARIABLES} -out="plan.out"
    terraform plan -out="plan.out"

apply:
    terraform apply plan.out

destroy:
    terraform destroy # ${VARIABLES} src

.PHONY = all init plan apply destroy up down