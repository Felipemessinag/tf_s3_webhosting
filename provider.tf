terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.62.0"
    }
  }
}

provider "aws" {
  secret_key = var.AWS_SECRET_ACCESS_KEY
  access_key = var.AWS_ACCESS_KEY_ID
  region     = "sa-east-1"
  # Configuration options
}

terraform {
  cloud {

    organization = "FelipeDevOps"

    workspaces {
      name = "devOps-felipe"
    }
  }
}
