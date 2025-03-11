##############################################################################
# Terraform Providers
##############################################################################

terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
    }
  }
  required_version = ">= 0.13"
}

##############################################################################

##############################################################################
# IBM Cloud Provider
##############################################################################

provider "ibm" {
  region = var.region
  # uncomment if using local terraform
  ibmcloud_api_key = var.ibm_api_key
}

##############################################################################
