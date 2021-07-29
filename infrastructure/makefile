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

# -backend=true \
# 		-backend-config="profile=$(AWS_PROFILE)" \
# 		-backend-config="region=$(REGION)" \
# 		-backend-config="bucket=$(S3_BUCKET)" \
# 		-backend-config="key=$(ENV)/$(CURRENT_FOLDER)/terraform.tfstate" \

# -backend-config="bucket=devopscube-states" \
# -backend-config="prefix=demo" \
# -backend-config="credentials=service-account.json"

BACKEND_CONFIG =    -backend-config="bucket='$${{ secrets.GCP_PROJECT }}'" \
					-backend-config="credentials='$${{ secrets.SERVICE_ACCOUNT_KEY }}'"
#                    -backend-config=key='$${{ secrets.AZURE_TERRAFORM_RESOURCE_GROUP_NAME }}.tfstate'

#VARIABLES = -var=path=${PWD}/config/resource-groups \

.PHONY = all init plan apply destroy up down

all:

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
