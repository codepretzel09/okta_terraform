locals {
  groups_csv = csvdecode(file("${path.module}/groups.csv"))
  groups     = { for groups in local.groups_csv : groups.name => groups }
}
# create groups from csv
resource "okta_group" "create" {
  for_each    = local.groups
  name        = each.value.name
  description = each.value.description
  skip_users  = true
}
# create output for each group
output "name" {
  value = tomap({
    for k, groups in okta_group.create : k => groups.id
  })
}


