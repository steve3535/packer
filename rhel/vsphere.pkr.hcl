packer {
  required_plugins {
    vsphere = {
      version = ">= 1.1.0"
      source = "github.com/hashicorp/vsphere"
    }
  }
}

source "vsphere-iso" "rhel8" {
  CPUs                 = 2
  cpu_cores            = 1
  RAM                  = 4096
  RAM_reserve_all      = true
  RAM_hot_plug          = true
  firmware             = "efi"
  boot_command         = ["<up>e<down><down><end><wait> text inst.ks=cdrom:/dev/sr1:/vsphere-ks.cfg<leftCtrlOn>x<leftCtrlOff>"]
  disk_controller_type = ["pvscsi"]
  guest_os_type        = "rhel7_64Guest"
  datacenter           = "LALUX"
  cluster              = "Cluster NUTANIX DMZ"
  folder               = "DMZ/Templates DMZ"
  host                 = "nut-dmz-03.lalux.local"
  insecure_connection  = true
  datastore            = "NUT_DMZ_ISO_DC1"
  iso_paths           = [
                         "[NUT_DMZ_ISO_DC1] ISO/rhel-8.6-x86_64-dvd.iso"
                        ]
  iso_checksum         = "md5:a5358b999ab1da0a7d4ea15d21367a2a"
  cd_files             = ["${path.root}/kickstart_files/vsphere-ks.cfg"] #en lieu et place de floppy_files car floppy no more supported with rhel8 and above

  #sassurer que le VLAN choisi provide du dhcp sinon le script va attendre indefiniment pour lip
  network_adapters {
    network = "DMZ_MGMT_VLAN20"
    network_card = "vmxnet3"
  }
  ssh_timeout  = "10m"
  ssh_username = "localadmin"
  ssh_password = yamldecode(file("credentials.yml")).vm.ssh_password
  storage {
    disk_size             = 51200
    disk_thin_provisioned = true
  }
  username        = yamldecode(file("credentials.yml")).lu309.username
  password        = yamldecode(file("credentials.yml")).lu309.password
  vcenter_server = "lu309"

  vm_name        = "RHEL8STD"

  #eventuellement creer le content library dans vsphere et donner les droits dy lire et ecrire au user utilisé pour se connecter a vsphere
  content_library_destination {
            library = "Linux_Templates_DC1"
            ovf = true
  }

}

build {
  sources = ["source.vsphere-iso.rhel8"]

  provisioner "shell" {
    inline = ["ls /"]
  }
}
