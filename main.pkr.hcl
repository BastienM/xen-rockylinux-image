packer {
  required_plugins {
   xenserver= {
      version = ">= v0.3.2"
      source = "github.com/ddelnano/xenserver"
    }
  }
}

variable "remote_host" {
  type        = string
  description = "The ip or fqdn of your XenServer. This will be pulled from the env var 'PKR_VAR_remote_host'"
  sensitive   = true
  default     = null
}

variable "remote_password" {
  type        = string
  description = "The password used to interact with your XenServer. This will be pulled from the env var 'PKR_VAR_remote_password'"
  sensitive   = true
  default     = null
}

variable "remote_username" {
  type        = string
  description = "The username used to interact with your XenServer. This will be pulled from the env var 'PKR_VAR_remote_username'"
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

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "") 
}

source "xenserver-iso" "main" {
  iso_checksum      = "0de5f12eba93e00fefc06cdb0aa4389a0972a4212977362ea18bde46a1a1aa4f"
  iso_checksum_type = "sha256"
  iso_url           = "https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.4-x86_64-minimal.iso" 

  sr_iso_name    = var.sr_iso_name
  sr_name        = var.sr_name
  tools_iso_name = "guest-tools.iso"

  remote_host     = var.remote_host
  remote_password = var.remote_password
  remote_username = var.remote_username

  vm_name        = "packer-rockylinux8-netinstall-${local.timestamp}"
  vm_description = "Build started: ${local.timestamp}\n This was installed with an external repository"
  disk_size      = 16000

  http_directory = "http/"
  boot_command   = ["<up><tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-base.cfg<enter><wait>"]
  boot_wait      = "10s"

  ssh_username     = "root"
  ssh_password     = "root"
  ssh_wait_timeout = "10000s"

  output_directory = "build"
}

build {
  sources = ["xenserver-iso.main"]
}
