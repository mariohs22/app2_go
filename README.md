![CI/CD](https://github.com/mariohs22/app2_go/actions/workflows/workflow.yml/badge.svg?branch=main)

# Golang Application (app2_go)

This is Golang application repo, created for [Andersen DevOps Course May-July`2021 exam](https://github.com/mariohs22/andersen-devops-course/tree/main/exam).

## Description

This is simple `Hello world` dockerized Golang application. On every push or pull request on main branch of this repo GitHub runs action script to perform CI/CD:

- Static analysis of .go files (by [golangci-lint](https://github.com/golangci/golangci-lint));
- Golang security check (by [gosec](https://github.com/securego/gosec));
- Unit tests (Golang built-in);
- Build docker container and deploy it to [Google Cloud Platform](https://cloud.google.com/);
- Cleanup of Google Container Registry.

**Final result** (if CI/CD job is success) is available on [https://app-go-service2-wwaf2ot3bq-uc.a.run.app](https://app-go-service2-wwaf2ot3bq-uc.a.run.app).

You will receive a telegram message if CI/CD job has failed, and if succeeded - you also receive web link to recently deployed application.

![CI/CD diagram](./diagram/app2.png)

## Usage

In order to operate this workflow, you'll need **Google Cloud Platform** (GCP) account. There is a [free tier](https://cloud.google.com/free/) that includes $300 of free credit overs a 12 month period.

Create a GCP project. Create Service Account, assign the roles: `Editor`, `Cloud Run Admin`. Download the service account credentials key (JSON-file).

Enable the Cloud Run API and the Container Registry API, detailed information is [here](https://robmorgan.id.au/posts/deploy-a-serverless-cicd-pipeline-on-gcp-using-cloud-run-and-terraform/) if neseccary.

To use notifications you need to create a Telegram bot by talking to [@BotFather](https://t.me/botfather) bot. See official guide here: [https://core.telegram.org/bots#6-botfather](https://core.telegram.org/bots#6-botfather).

Fork this repository. Fill in environmental variables in ./github/workflows/workflow.yml and GitHub secrets (see below) according to your data. Every push or pull request on main branch will trigger the CI/CD pipeline to deploy the application. You'll receive web link to application in telegram.

### Secret management

CI/CD job uses GitHub secrets, which you can setting up on `Settings / Secrets` section:

- `SERVICE_ACCOUNT_KEY` - Google service account credentials (JSON).
- `TELEGRAM_TOKEN` - Telegram Bot token.
- `TELEGRAM_TO` - Your telegram channel (`@channelname`) or user id. You can find your user id, for example by talking to [@jsondumpbot](https://t.me/jsondumpbot)

### LOGS

You can see logs of every CI/CD job in [Actions](https://github.com/mariohs22/app2_go/actions) section of current repo. Also logs are available at Google Cloud Platform.
