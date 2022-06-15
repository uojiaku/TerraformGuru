# terraform.tfvars

# First we define how many controller nodes and worker nodes we want to deploy
control-count = "3"
worker-count = "3"

# VM Configuration
vm-prefix = "k8s"
vm-template-name = "ubnt-packer"
vm-cpu = "2"
vm-ram = "4096"
vm-guest-id = "ubuntu64Guest"
vm-datastore = "NVME"
vm-network = "VLAN128"
vm-domain = "virtjo.local"

# vSphere configuration
vsphere-vcenter = "vcsa.virtjo.local"
vsphere-unverified-ssl = "true"
vsphere-datacenter = "SDDC"
vsphere-cluster = "cluster01"

# vSphere username defined in environment variable
# export TF_VAR_vsphereuser=$(pass vsphere-user)

# vSphere password defined in environment variable
# export TF_VAR_vspherepass=$(pass vsphere-password)