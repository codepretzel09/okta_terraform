variable "label" {
  description = "app label"
}
variable "rule_name" {
  description = "name of the rule"
}
variable "access" {
  description = "ALLOW OR DENY"
  default     = "DENY"
}
variable "priority" {
  description = "rule priority"
  type        = number
}
variable "factor_mode" {
  description = "2FA or 1FA"
  default     = "2FA"
}

/*
variable "device_is_managed" {
  description = "Device is Managed by JAMF"
  #default     = true
}

variable "device_is_registered" {
  description = "Device is registered in Okta"

}
*/

variable "groups" {
  description = "okta groups"
  type        = list(string)
  default     = []
}

variable "constraints" {

}
variable "network_connection" {
  default = "ANYWHERE"
}


variable "re_authentication_frequency" {
  default = "PT14H"
}

# variable "risk" {
#     description = "risk level"
#     default = "High"
# }

variable "network_includes" {
  description = "Include networks on app policy rule"
  type        = list(string)
  default     = []
}
