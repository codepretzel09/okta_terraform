variable "label" {
  description = "app label"
}
variable "preconfigured_app" {
  description = "must match exact string in Okta's Catalog"
}
variable "firstname" {
  description = "attribute statement"
  default     = "firstname"
}
variable "lastname" {
  description = "attribute statement"
  default     = "lastname"
}
variable "email" {
  description = "attribute statement"
  default     = "email"
}
variable "settings" {
  description = "app settings"
  default     = {}
}
variable "attribute_statements" {
  description = "custom attributes"
  default     = {}
}
variable "groups" {
  default = []
}
variable "app_links" {
  description = "app visibility settings under general in okta UI per each app"
  default     = {}
}
variable "hide_ios" {
  default = false
}
variable "hide_web" {
  default = false
}