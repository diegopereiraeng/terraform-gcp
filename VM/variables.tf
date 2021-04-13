variable "project" {
  description = "The Google project to be used"
  type        = string
  default     = ""
}

variable "region" {
  description = "Resource Region"
  type        = string
}
variable "zone" {
  description = "Resource Zone"
  type        = string
}

variable "gcp_sa" {
  description = "The Google Service Account to be used to create the resources"
  type        = string
  default     = ""
}

variable "ssh_keys" {
  description = "The ssh keys to connect to GCP VM Instance"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "The VM Instance Type"
  type        = string
  default     = ""
}
