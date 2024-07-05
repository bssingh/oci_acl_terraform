provider "oci" {
  auth = "SecurityToken"
  config_file_profile = "ASH"
  region = "us-ashburn-1"
}

# Read the JSON file into a Terraform variable
locals {
   services = jsondecode(file(var.service_file))
   applications = jsondecode(file(var.applications_file))
   application_group = jsondecode(file(var.application_list_file))
}

################################
#  Create or update policy
###############################
resource "oci_network_firewall_network_firewall_policy" "test_network_firewall_policy" {
    #Required
    compartment_id = var.compartment_ocid

    #Optional
#    defined_tags = {"Operations.CostCenter"= "42"}
    display_name = var.network_firewall_policy_display_name
#    freeform_tags = {"Department"= "Finance"}
}

###########################################
#  Create or update services
###########################################

# Iterate over each address list in the JSON and create resources
resource "oci_network_firewall_network_firewall_policy_service" "dynamic_services" {
  count = length(local.services)

  # Specify explicit dependency on the network firewall policy
  depends_on = [
    oci_network_firewall_network_firewall_policy.test_network_firewall_policy
  ]

  name                       = local.services[count.index].name
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.test_network_firewall_policy.id
  type                       = local.services[count.index].type
  # Iterate over each port range for the current service
  dynamic "port_ranges" {
    for_each = local.services[count.index].portRanges
    content {
      minimum_port = port_ranges.value.minimumPort
      maximum_port = port_ranges.value.maximumPort
    }
  }
  # Other optional configurations can go here
}

####################################
#  Create or update applications
###################################
resource "oci_network_firewall_network_firewall_policy_application" "dynamic_applications" {
  count = length(local.applications)

  # Specify explicit dependency on the network firewall policy
  depends_on = [
    oci_network_firewall_network_firewall_policy.test_network_firewall_policy
  ]

  name                       = local.applications[count.index].name
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.test_network_firewall_policy.id
  type                       = local.applications[count.index].type
  
  # Optional attributes
  icmp_type                  = try(local.applications[count.index].icmpType, null)
  icmp_code                  = try(local.applications[count.index].icmpCode, null)

  # Other optional configurations can go here
}

