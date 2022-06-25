data "okta_app_saml" "app_saml" {
  label = var.label
}
data "okta_app_signon_policy" "app_saml_signon_policy" {
  app_id = data.okta_app_saml.app_saml.id
}

data "okta_user_type" "user" {
  name = "user"
}

resource "okta_app_signon_policy_rule" "create" {
  name              = var.rule_name
  priority          = var.priority
  policy_id         = data.okta_app_signon_policy.app_saml_signon_policy.id
  access            = var.access
  custom_expression = "user.status == \"ACTIVE\""
  #device_is_managed           = var.device_is_managed
  #device_is_registered        = var.device_is_registered
  factor_mode                 = var.factor_mode
  user_types_included         = [data.okta_user_type.user.id]
  re_authentication_frequency = var.re_authentication_frequency
  network_connection          = var.network_connection
  network_includes            = var.network_includes


  # Apply policy to group(s)
  count = length(var.groups)
  groups_included = [
    var.groups[count.index],
  ]

  # Constraints set by module input - Example: "deviceBound" : "REQUIRED" 
  constraints = [jsonencode(var.constraints)]


  # Device Platforms Allowed
  platform_include {
    os_type = "ANDROID"
    type    = "MOBILE"
  }
  platform_include {
    os_type = "IOS"
    type    = "MOBILE"
  }
  platform_include {
    os_type = "MACOS"
    type    = "DESKTOP"
  }
}
