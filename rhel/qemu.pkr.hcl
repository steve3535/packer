source "qemu" "rhel8" {
  iso_url           = "./rhel-8.6-x86_64-dvd.iso"
  iso_checksum      = "md5:a5358b999ab1da0a7d4ea15d21367a2a"
  output_directory  = "nutanix"
  shutdown_command  = "echo 'packer' | sudo -S shutdown -P now"
  disk_size         = "51200M"
  format            = "qcow2"
  accelerator       = "kvm"
  http_directory    = "."
  ssh_username      = "localadmin"
  ssh_password      = yamldecode(file("credentials.yml")).vm.ssh_password
  ssh_timeout       = "30m"
  vm_name           = "RHEL8STD"
  net_device        = "virtio-net"
  disk_interface    = "virtio"
  boot_wait         = "10s"
  boot_command      = ["<wait><wait>e<down><down><end><bs><bs><bs><bs><bs>inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kickstart_files/qemu-ks.cfg<leftCtrlOn>x<leftCtrlOff>"]
  firmware          = "/usr/share/ovmf/OVMF.fd"
  qemuargs = [
    [ "-m", "1024M" ],
    [ "-machine", "q35,accel=kvm" ],
  ]
}

build {
  sources = ["source.qemu.rhel8"]
}

