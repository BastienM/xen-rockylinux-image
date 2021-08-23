packer {
  required_plugins {
   xenserver= {
      version = ">= v0.3.2"
      source = "github.com/ddelnano/xenserver"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
  os_short_version = substr(var.os_version, 1, 1)
}

source "xenserver-iso" "main" {
  iso_checksum      = var.os_iso_checksum
  iso_checksum_type = "sha256"
  iso_url           = "https://download.rockylinux.org/pub/rocky/${local.os_short_version}/isos/${var.os_arch}/Rocky-${var.os_version}-${var.os_arch}-${var.os_iso_type}.iso" 

  sr_iso_name    = "rockylinux-${var.os_version}-${var.os_installmode}-${var.os_arch}.iso"
  sr_name        = var.sr_name
  tools_iso_name = "guest-tools.iso"

  remote_host     = var.xen_host
  remote_username = var.xen_username
  remote_password = var.xen_password

  vm_name        = "packer-rockylinux${var.os_version}-${var.os_installmode}-${local.timestamp}"
  vm_description = "Build started: ${local.timestamp}\n This was installed with an external repository"
  disk_size      = 16000

  http_directory = "http/"
  boot_command   = ["<up><tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-base.cfg<enter><wait>"]
  boot_wait      = "10s"

  ssh_username     = "root"
  ssh_password     = "root"
  ssh_wait_timeout = "10000s"

  output_directory = var.build_dir
}

build {
  sources = ["xenserver-iso.main"]
}
