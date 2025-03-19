variable "resource_group" {
  type        = string
  default     = "Stemdo_Sandbox"
  description = "The resource group to deploy the resources to."
}
variable "region" {
  type        = string
  default     = "eu-es"
  description = "The region to deploy the resources to."
}
variable "ibm_api_key" {
  description = "IBM Cloud api key"
  type        = string
}
