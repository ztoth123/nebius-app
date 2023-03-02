# nebius-app

# packer
## packer preparations
* install packer
* create the packer template
* intialize packer
```bash
packer init aws-ubuntu.pkr.hcl
Installed plugin github.com/hashicorp/amazon v1.2.1 in "/Users/zoltan/.config/packer/plugins/github.com/hashicorp/amazon/packer-plugin-amazon_v1.2.1_x5.0_darwin_arm64"
```
* validate the packer template
```bash
packer fmt .
aws-ubuntu.pkr.hcl
packer validate .
The configuration is valid.
```
## Build a customozed AMI image with packer
```bash
packer build .
```
# terraform
