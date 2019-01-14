variable "account_numbers" {
  description = "Account numbers for accounts allowed to be accessed by this terraform run"
  type        = "list"
  default     = ["457598648171"]
}

variable "region" {
  description = "region to deploy to"
  type        = "string"
  default     = "us-east-1"
}

variable "access_key" {
  type        = "string"
  default     = ""
}

variable "secret_key" {
  type        = "string"
  default     = ""
}

variable "token" {
  description = "MFA Token retrieved with sts get-session-token"
  type        = "string"
  default     = ""
}

variable "site_host" {
  description = "Host (fqdn minus root zone) of static site"
  type        = "string"
  default     = "terraform"
}

variable "site_root_zone" {
  description = "fqdn of root zone"
  type        = "string"
  default     = "chrismhurst-demos.com"
}
