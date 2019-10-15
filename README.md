# Netlify terraform

This guide assume that you already have installed terraform 

## Getting started
First of all, you need to install Netlify cli to you machine
```bash
npm install -g netlify
netlify login
```

create your environment file, `touch .env` and add this variables.
```bash
export TF_VAR_netlify_user_id=$(cat ~/.netlify/config.json | jq .userId)
export TF_VAR_netlify_token=$(cat ~/.netlify/config.json | jq -r .users.${TF_VAR_netlify_user_id}.auth.token)
export TF_VAR_project_name=project-name
export TF_VAR_client_name=client-name
```

then apply you environment
```bash
source .env
```

and then you should initialize terraform.
```bash
terraform init
```

## Setup an environment
To create a new environment, use command workspace and sub command new, for example:
```bash
terraform workspace new staging
```

Also, it necessary to create your .tfvars and add the values specified at variables.tf

## Deploy

To deploy new changes, you need to create plan and then apply it

```bash
mkdir plan/
terraform plan -var-file path/to/tfvars-file -out plan/staging.plan
terraform apply staging.plan
```
