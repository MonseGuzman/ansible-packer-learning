terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.70.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.2.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.7.0"
    }
  }
}

## Providers
provider "aws" {
  region = "us-west-2"
}

provider "azurerm" {
  features {}
}

provider "tls" {
}

provider "local" {
}