variable netlify_token {
  default = ""
}

variable client_name {
  type = string
  default = "client"
}

variable project_name {
  type = string
  default = "example"
}

# Environment
# allowed values ar staging, dev, production, master
variable environment {
  type = string
  default = "staging"
}

variable github_token {
  type = string
}
# Repository for CI/CD
# branch (mandatory): branch to deploy
# build_command (mandatory): build command: eg: npm run build
# dir (mandatory): directory to deploy: eg: build
# provider (mandatory): repsotiry provider: eg, github
# reponame (mandatory): repository path reponame
# organization (mandatory): repository organization
variable repository {
  type = "map"
}
