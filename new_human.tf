module "create_okta_user_FIRST_LAST" {
  # Okta attributes
  source = "../modules/okta_user"
  status = "ACTIVE"
  # User Information
  user_type  = "Employee"
  user_email = "@redcanary.com"
  # Name Information
  first_name = ""
  last_name  = ""
  #     middleName = ""
  #     honorificPrefix = ""
  #     honorificSuffix = ""
  # Contact Information
  second_email = null
  mobile_phone = ""
  # Location Information
  state = "CO"
   country_code = "US"
  # Job Information
  organization = "Red Canary"
  division     = "Business Operations"
  department   = "Information Technology"
  cost_center  = "Systems Engineering"
  title        = "Senior Systems Engineer"
  #     manager_id = ""
  manager = "steven.correa@redcanary.com"
  # What groups are they a part of
  groups = [
  ]
}
