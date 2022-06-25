variable "label" {
  description = "app label"
}
variable "entityid_url" {
  description = "Entity ID URL"
}
variable "acs_url" {
  description = "ACS URL"
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
variable "groups" {
  default = []
}
variable "logo" {
  default = null
}
variable "subject_name_id_format" {
  default = "urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified"
}
variable "hide_ios" {
  default = false
}
variable "hide_web" {
  default = false
}