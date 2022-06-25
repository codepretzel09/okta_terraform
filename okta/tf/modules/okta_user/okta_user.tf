## OKTA USER CREATION MODULE
# create user with profile attributes specififed in their corresponding human file
resource "okta_user" "create" {
  first_name                = var.first_name
  last_name                 = var.last_name
  login                     = var.user_email
  email                     = var.user_email
  department                = var.department
  status                    = var.status
  user_type                 = var.user_type
  division                  = var.division
  organization              = var.organization
  cost_center               = var.cost_center
  title                     = var.title
  mobile_phone              = var.mobile_phone
  manager                   = var.manager
  manager_id                = var.manager_id
  middle_name               = var.middle_name
  honorific_prefix          = var.honorific_prefix
  honorific_suffix          = var.honorific_suffix
  second_email              = var.second_email
  custom_profile_attributes = var.attributes
}

resource "okta_user_group_memberships" "test" {
  count   = length(var.groups)
  user_id = okta_user.create.id
  groups = [
    var.groups[count.index],
  ]
}

output "userid" {
  value = okta_user.create.id
}

output "email" {
  value = okta_user.create.email
}

