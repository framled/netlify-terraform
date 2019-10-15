locals {
  project_name = "${var.client_name}-${var.project_name}-${var.environment}"
  repo_path = "${var.repository["organization"]}/${var.repository["reponame"]}"
}

# Configure the Netlify Provider
provider "netlify" {
  token    = var.netlify_token
}

provider "github" {
  token        = var.github_token
  organization = var.repository["organization"]
}

# Create a new deploy key for this specific website
resource "netlify_deploy_key" "key" {}

# Define your site
resource "netlify_site" "main" {
  name = local.project_name

  repo {
    repo_branch   = var.repository["branch"]
    command       = var.repository["build_command"]
    deploy_key_id = netlify_deploy_key.key.id
    dir           = var.repository["dir"]
    provider      = "github"
    repo_path     = local.repo_path
  }
}

resource "github_repository_deploy_key" "key" {
  title      = "Netlify"
  repository = var.repository["reponame"]
  key        = netlify_deploy_key.key.public_key
  read_only  = false
}

// Create a webhook that triggers Netlify builds on push.
resource "github_repository_webhook" "main" {
  repository = var.repository["reponame"]
  events     = ["delete", "push", "pull_request"]

  configuration {
    content_type = "json"
    url          = "https://api.netlify.com/hooks/github"
  }

  depends_on = ["netlify_site.main"]
}
