data "okta_group" "groups" {
  for_each = { for group in var.groups : group.name => group }
  name     = each.value.name
}

resource "okta_app_saml" "create" {
  label                   = var.label
  preconfigured_app       = var.preconfigured_app
  status                  = "ACTIVE"
  user_name_template      = "$${source.login}"
  user_name_template_type = "BUILT_IN"
  app_links_json          = jsonencode(var.app_links)
  hide_ios                = var.hide_ios
  hide_web                = var.hide_web

  dynamic "attribute_statements" {
    for_each = try(var.attribute_statements, [])

    content {
      type      = "EXPRESSION"
      namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:${attribute_statements.value.namespace}"
      name      = attribute_statements.value.name
      values    = [attribute_statements.value.value]
    }
  }

  lifecycle {
    ignore_changes = [groups]
  }
}

resource "okta_app_saml_app_settings" "create" {
  settings = jsonencode(var.settings)
  app_id   = okta_app_saml.create.id
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


