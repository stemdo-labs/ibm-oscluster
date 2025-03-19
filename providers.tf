##############################################################################
# Terraform Providers
##############################################################################

terraform {
  # backend "s3" {
  #   bucket = "gobernanza-ibm-bkt"
  #   key    = "cluster/terraform.tfstate"
  #   region = "us-east-1"  
  #   endpoints = {
  #     s3 = "https://s3.eu-es.cloud-object-storage.appdomain.cloud"
  #   }
  #   skip_credentials_validation = true
  #   skip_metadata_api_check     = true
  #   skip_region_validation = true
  #   skip_requesting_account_id  = true
  #   use_path_style = true
  #   skip_s3_checksum = true
  # }
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
