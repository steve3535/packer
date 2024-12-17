# packer

## Using qemu builder to set packer configuration for Nutanix  
* the script will output a qcow2 image file, that you can then ship to Image store in Nutanix  
## Using vsphere-iso builder to set packer configuration for VMware ESX  
* the script will provision a VM and will turn it into a template stored in a local content library of the vcenter

## packer in air-gap env  
```bash
 export PACKER_PLUGIN_PATH=/root/.config/packer/plugins
 /usr/local/bin/packer plugins installed
 sha256sum packer-plugin-qemu_v1.1.0_x5.0_linux_amd64
 echo -n 5f3e17966617b9f1c1ab92d6fc1cd4e7bc68d7744e515197f6d3b3215140c668 > packer-plugin-qemu_v1.1.0_x5.0_linux_amd64_SHA256SUM
 /usr/local/bin/packer plugins installed
 mkdir qemu
 mv packer-plugin-qemu_v1.1.0_x5.0_linux_amd64* qemu
 /usr/local/bin/packer plugins installed
 chmod +x docker/packer-plugin-docker_v1.0.8_x5.0_linux_amd64
 /usr/local/bin/packer plugins installed
 chmod +x vmware/packer-plugin-vmware_v1.0.7_x5.0_linux_amd64
 chmod +x vsphere/packer-plugin-vsphere_v1.1.0_x5.0_linux_amd64
 /usr/local/bin/packer plugins installed
 vi ~/.bashrc
 /usr/local/bin/packer plugins installed
 ```


