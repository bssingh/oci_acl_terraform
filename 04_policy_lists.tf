# Read the JSON file into a Terraform variable
locals {
   address_lists = jsondecode(file(var.address_file))
   service_list = jsondecode(file(var.service_list_file))
   url_lists = jsondecode(file(var.url_list_file))
}

####################################
#  Create or update services Lists
###################################
# Create OCI network firewall policy application group resources dynamically
resource "oci_network_firewall_network_firewall_policy_service_list" "dynamic_service_list" {
  count = length(local.service_list)

  depends_on = [
    oci_network_firewall_network_firewall_policy_service.dynamic_services
  ]
  name = local.service_list[count.index].name
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.test_network_firewall_policy.id
  services = local.service_list[count.index].services
}


##################################
#  Create or update address_lists
###################################

# Iterate over each address list in the JSON and create resources
resource "oci_network_firewall_network_firewall_policy_address_list" "dynamic_address_lists" {
  count = length(local.address_lists)

  name                       = local.address_lists[count.index].name
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.test_network_firewall_policy.id
  type                       = local.address_lists[count.index].type
  addresses                  = local.address_lists[count.index].addresses

  # Other optional configurations can go here
}


####################################
#  Create or update applications Lists
###################################
# Create OCI network firewall policy application group resources dynamically
resource "oci_network_firewall_network_firewall_policy_application_group" "dynamic_application_groups" {
  count = length(local.application_group)

  depends_on = [
    oci_network_firewall_network_firewall_policy_application.dynamic_applications 
  ]
  name                       = local.application_group[count.index].name
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.test_network_firewall_policy.id
  apps                       = local.application_group[count.index].apps
}


####################################
#  Create or update url Lists
###################################
# Create OCI network firewall policy URL list resources dynamically based on the length of the JSON array
resource "oci_network_firewall_network_firewall_policy_url_list" "dynamic_url_lists" {
  count                      = length(local.url_lists)

  name                       = local.url_lists[count.index].name
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.test_network_firewall_policy.id
  
  depends_on = [
    oci_network_firewall_network_firewall_policy.test_network_firewall_policy
  ]
  dynamic "urls" {
    for_each = local.url_lists[count.index].urls
    content {
      pattern = urls.value.pattern
      type = urls.value.type
    }
  }
}

