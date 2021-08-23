variable "build_dir" {
  type = string
  description = "Where to store the built images"
  default = null
}

variable "os_version" {
  type = string
  description = "The version of the OS being used to build the image"
  default = null
}

variable "os_arch" {
  type = string
  description = "The arch of the OS being used to build the image"
  default = null
}

variable "os_installmode" {
  type        = string
  description = "The install method of the OS being used to build the image"
  default     = null
}

variable "os_iso_type" {
  type = string
  description = "Media type of the OS iso being used to build the image"
  default = null
}

variable "os_iso_checksum" {
  type = string
  description = "Cheksum of the OS iso being used to build the image"
  default = null
}

variable "xen_host" {
  type        = string
  description = "The ip or fqdn of your XenServer. This will be pulled from the env var 'PKR_VAR_remote_host'"
  sensitive   = true
  default     = null
}

variable "xen_username" {
  type        = string
  description = "The username used to interact with your XenServer. This will be pulled from the env var 'PKR_VAR_remote_username'"
  sensitive   = true
  default     = null
}

variable "xen_password" {
  type        = string
  description = "The password used to interact with your XenServer. This will be pulled from the env var 'PKR_VAR_remote_password'"
  sensitive   = true
  default     = null
}

variable "sr_iso_name" {
  type        = string
  default     = ""
  description = "The ISO-SR to packer will use"

}

variable "sr_name" {
  type        = string
  default     = ""
  description = "The name of the SR to packer will use"
}