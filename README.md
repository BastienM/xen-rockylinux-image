# xen-rockylinux-image

RockyLinux image builder for Xen-based hypervisors built with Packer

## Requirements

- Packer >= 1.7
- Taskfile >= 3.7

## How-to

### Available actions

```sh
$ task --list
task: Available tasks for this project:
* build:        Build the image
* clean:        Remove old and unneccessary artifacts
* validate:     Validate the template
```

### Pre-requirement

```sh
cat > secrets.pkrvars.hcl <<EOF
xen_host = "<IP or FQDN of your Xen/XCP host>"
xen_username = "<User's name to log in into the host>"
xen_password = "<User's password>"
sr_name = "<SR where to store the ISO>"
sr_iso_name = "<ISO name>"
EOF
```
