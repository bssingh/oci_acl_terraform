# VCN

# Read the JSON file into a Terraform variable
locals {
   security_rules = jsondecode(file(var.security_list_file))
}

#############################################
# Create security rules
#############################################
resource "oci_network_firewall_network_firewall_policy_security_rule" "dynamic_security_rules" {
  count = length(local.security_rules)
 
  depends_on = [
    oci_network_firewall_network_firewall_policy_address_list.dynamic_address_lists,
    oci_network_firewall_network_firewall_policy_url_list.dynamic_url_lists,
    oci_network_firewall_network_firewall_policy_service.dynamic_services,
    oci_network_firewall_network_firewall_policy_application_group.dynamic_application_groups,
    oci_network_firewall_network_firewall_policy.test_network_firewall_policy
  ]
  action = local.security_rules[count.index].action
  name = local.security_rules[count.index].name
  condition {
    application = local.security_rules[count.index].condition.application
    destination_address = local.security_rules[count.index].condition.destinationAddress
    service = local.security_rules[count.index].condition.service
    source_address = local.security_rules[count.index].condition.sourceAddress
    url = local.security_rules[count.index].condition.url
  }

  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.test_network_firewall_policy.id
}
