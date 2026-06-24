terraform {
  backend "s3" {
    bucket                      = "tfstate-cluster-bootcamp"
    key                         = "bootcamp/cluster/terraform.tfstate"
    region                      = "eu-es"
    endpoints = {
      s3 = "https://s3.eu-es.cloud-object-storage.appdomain.cloud"
    }

    # Parámetros para IBM Cloud COS para desactivar validaciones
    skip_credentials_validation = true  # 
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true 
  }
}