Project Documentation: OCI Firewall Policy Creation

Overview
This repository automates the creation of Oracle Cloud Infrastructure (OCI) firewall policies using Terraform. The firewall policies are defined and configured based on JSON files located in the policy/ directory. This documentation outlines the purpose of each JSON file and how Terraform applies them to generate firewall policies.

Directory Structure
The policy/ directory contains the following JSON files:

address_list.json
applications.json
service.json
url_list.json
application_list.json
security_rules.json
service_list.json
File Descriptions
address_list.json

Defines address lists with specific IP addresses or CIDR ranges.
Used to specify source and destination addresses in firewall rules.
applications.json

Defines applications or protocols that are allowed or denied.
Specifies ICMP types, codes, and other application-specific details.
service.json

Defines network services with port ranges.
Specifies TCP/UDP ports allowed or denied.
url_list.json

Defines URL patterns that are allowed or denied.
Used for URL filtering in firewall rules.
application_list.json

Groups applications defined in applications.json into application lists.
Enables easier management and referencing of application groups in firewall rules.
security_rules.json

Combines address lists, application lists, services, and URL lists to define firewall rules.
Specifies the action (allow/deny), priority, and logging settings for each rule.
service_list.json

Groups services defined in service.json into service lists.
Simplifies referencing and management of service groups in firewall rules.
Terraform Automation
Using Terraform, executing terraform apply applies the configurations defined in the JSON files to create OCI firewall policies. Each JSON file corresponds to specific resources and configurations within Terraform:

OCI Network Firewall Policies: Defined based on the JSON configurations.
Rule Creation: Converts rules specified in security_rules.json into OCI network firewall rules.
Modularity: JSON files allow easy updates and modifications to firewall policies without directly altering Terraform configurations.
Usage
To apply changes or create new firewall policies:

Modify the JSON files in the policy/ directory according to your requirements.
Execute terraform apply to update or create OCI firewall policies based on the modified JSON configurations.
Conclusion
This repository provides a structured approach to managing OCI firewall policies using JSON configurations and Terraform automation. It simplifies policy management, enhances consistency, and ensures adherence to defined security requirements across Oracle Cloud Infrastructure environments.

