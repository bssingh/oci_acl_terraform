variable "region" {
  type = string
  default = "us-ashburn-1"
}
variable "tenancy_ocid" {
  type = string
  default = "Add your OCID"
}
variable "compartment_ocid" {
  type = string
  default = "Add your ocid"
}

variable "network_firewall_policy_display_name" {
  type = string
  default = "oci_policy_1"
}

variable "network_firewall_address_list_name" {
  type = string
  default = "address_list"
}

variable "network_firewall_url_list_name" {
  type = string
  default = "url_list"
}

variable "network_firewall_service_list_name" {
  type = string
  default = "service_list"
}

variable "network_firewall_application_list_name" {
  type = string
  default = "application_list"
}

variable "address_file" {
  description = "Path to the JSON file containing addresses"
  default     = "policy/address_list.json"
}

variable "service_list_file" {
  description = "Path to the JSON file containing addresses"
  default     = "policy/service_list.json"
}

variable "security_list_file" {
  description = "Path to the JSON file containing addresses"
  default     = "policy/security_rules.json"
}

variable "url_list_file" {
  description = "Path to the JSON file containing addresses"
  default     = "policy/url_list.json"
}

variable "application_list_file" {
  description = "Path to the JSON file containing addresses"
  default     = "policy/application_list.json"
}

variable "service_file" {
  description = "Path to the JSON file containing addresses"
  default     = "policy/service.json"
}

variable "urls_file" {
  description = "Path to the JSON file containing addresses"
  default     = "policy/urls.json"
}

variable "applications_file" {
  description = "Path to the JSON file containing addresses"
  default     = "policy/applications.json"
}

