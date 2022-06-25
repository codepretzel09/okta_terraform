###  There are more arguments avalaible to pass in if needed - see the link below and add accordingly
###  https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_bookmark
###  


resource "okta_app_bookmark" "create" {
  label        = var.label
  url          = var.url
  logo         = var.logo
  admin_note   = var.admin_note
  enduser_note = var.enduser_note

  lifecycle {
    ignore_changes = [groups]

  }

}

data "okta_group" "groups" {
  for_each = { for group in var.groups : group.name => group }
  name     = each.value.name
}

resource "okta_app_group_assignments" "saml" {
  for_each = { for group in var.groups : group.name => group }
  app_id   = okta_app_bookmark.create.id

  dynamic "group" {
    for_each = toset(var.groups)

    content {
      id = data.okta_group.groups[each.key].id
      # priority = try(group.key, null)
      # profile  = try(jsonencode(group.value.profile), null)
    }
  }
}
