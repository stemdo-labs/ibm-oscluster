##############################################################################
# Terraform Providers
##############################################################################

terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "~>1.38.2"
    }
  }
  required_version = ">=1.0"
#  experiments      = [module_variable_optional_attrs]
}

##############################################################################

provider "ibm" {
  # ibmcloud_api_key = var.ibmcloud_api_key # comment out and remove variable for schematics runs
  region           = "eu-es"
  ibmcloud_timeout = 60
}

resource "ibm_resource_instance" "cos_instance" {
  name     = "my_cos_instance"
  service  = "cloud-object-storage"
  plan     = "standard"
  location = "global"
  resource_group_id = "4364ced224cf420fa07d8bf70a8d70df"
}

resource "ibm_container_vpc_cluster" "cluster" {
  name              = "my_vpc_cluster"
  vpc_id            = "r006-abb7c7ea-aadf-41bd-94c5-b8521736fadf"
  kube_version      = "4.3_openshift"
  flavor            = "bx2.16x64"
  worker_count      = "2"
  entitlement       = "cloud_pak"
  cos_instance_crn  = ibm_resource_instance.cos_instance.id
  resource_group_id = "4364ced224cf420fa07d8bf70a8d70df"
  zones {
      subnet_id = "02x7-de5333da-a635-4714-a7aa-bc364387f052"
      name      = "eu-es"
    }
}