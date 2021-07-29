# GCP_PROJECT = "app-go-terraform"
# GCP_LOCATION = "us-central1"
# GCP_REGION = "us"
# GCP_SERVICE_NAME = "app-go-service"
# GCP_IMAGE_NAME = "gcr.io/cloudrun/appgo"
# terraform init -reconfigure ${BACKEND_CONFIG} src
# terraform plan ${VARIABLES} -out="plan.out"
# terraform destroy ${VARIABLES} src

export TF_VAR_project='$${{ secrets.GCP_PROJECT }}'
export TF_VAR_location='$${{ secrets.GCP_LOCATION }}'
export TF_VAR_gcr_region='$${{ secrets.GCP_REGION }}'
export TF_VAR_service_name='$${{ secrets.GCP_SERVICE_NAME }}'
export TF_VAR_image_name='$${{ secrets.GCP_IMAGE_NAME }}'


BACKEND_CONFIG =    -backend-config=project='$${{ secrets.GCP_PROJECT }}' \
                    -backend-config=location='$${{ secrets.GCP_LOCATION }}' \
                    -backend-config=gcr_region='$${{ secrets.GCP_REGION }}' \
					-backend-config=service_name='$${{ secrets.GCP_SERVICE_NAME }}' \
					-backend-config=image_name='$${{ secrets.GCP_IMAGE_NAME }}'
#                    -backend-config=key='$${{ secrets.AZURE_TERRAFORM_RESOURCE_GROUP_NAME }}.tfstate'

#VARIABLES = -var=path=${PWD}/config/resource-groups \

.PHONY = all init plan apply destroy up down

up: init plan apply

down: init destroy

init:
	terraform init -reconfigure ${BACKEND_CONFIG}

plan:
	terraform plan -out="plan.out"

apply:
	terraform apply plan.out

destroy:
	terraform destroy
