data "okta_group" "groups" {
  for_each = { for group in var.groups : group.name => group }
  name     = each.value.name
}

resource "okta_app_saml" "create" {
  label               = var.label
  audience            = var.entityid_url
  recipient           = var.acs_url
  sso_url             = var.acs_url
  destination         = var.acs_url
  signature_algorithm = "RSA_SHA256"
  digest_algorithm    = "SHA256"
  assertion_signed    = "true"
  honor_force_authn   = "true"
  response_signed     = "true"
  logo                = var.logo
  hide_ios            = var.hide_ios
  hide_web            = var.hide_web
  # logo     = "${path.module}/logos/${each.value.label}.png"

  authn_context_class_ref = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"

  subject_name_id_format   = var.subject_name_id_format
  subject_name_id_template = "$${user.userName}"

  lifecycle {
    ignore_changes = [groups]

  }
  attribute_statements {
    name      = var.firstname
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified"
    type      = "EXPRESSION"
    values = [
    "user.firstName", ]

  }
  attribute_statements {
    name      = var.lastname
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified"
    type      = "EXPRESSION"
    values = [
    "user.lastName", ]

  }
  attribute_statements {
    name      = var.email
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified"
    type      = "EXPRESSION"
    values = [
      "user.email",
    ]
  }
}

resource "okta_app_group_assignments" "saml" {
  for_each = { for group in var.groups : group.name => group }
  app_id   = okta_app_saml.create.id

  dynamic "group" {
    for_each = toset(var.groups)

    content {
      id = data.okta_group.groups[each.key].id
      # priority = try(group.key, null)
      # profile  = try(jsonencode(group.value.profile), null)
    }
  }
}

