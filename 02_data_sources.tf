# Availability Domain
data "oci_identity_availability_domain" "AD" {
    compartment_id = var.tenancy_ocid
    ad_number = 1
}

