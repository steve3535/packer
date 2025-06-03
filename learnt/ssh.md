### How does ssh work in packer ?
* Once you start a packer session, at the very beginning, it will spark a ssh agent via its builtin ssh communicator mechanism, that ssh agent is forwarding the "future" vm instance ssh port to localhost on a certain port that is even displayed at the very begining of the session
* With qemu provisionner, when using a usermode networking, the host it self doesnt have access to the network, which is inside qemu and hence isolated from the host, hence the necessity of ssh port forwarding
* sometimes, it happened that i have to use qemuargs to explicitly set the port forwarding but according to packer docs, this shouldnt be required: packer handles it
* something i noticed however is that sometimes the ssh connection prior toexecuting the provisionners, fails. It times out. the only solution seems to increase the timeout delay ...
  * to workaround the delay, we can use the accelerator = kvm for qemu provisionner, but be aware: this needs the user running the process to be part of the kvm group
  * !!ATTN!! other times, the ssh delay is just a result of a wrong ssh password, check that as well ! the password might have changed !
### In case of more than one interface  
* Some weird bbehaviours can occur in case of 2 or more interfaces. from my exp., packer will struggle to determine on which interface ssh is listening or from which it should redirect from.  
  In such case, we need to add qemuargs to explicitly forward the port from a specific interface, for e.g. in case of opnsense, the WAN is exposed interface, in packer.hcl.pkr:  
  ```
    qemuargs = [
    # First network interface (LAN - vtnet0)
    ["-netdev", "user,id=net0"],
    ["-device", "virtio-net,netdev=net0"],
    
    # Second network interface (WAN - vtnet1)
    ["-netdev", "user,id=net1,hostfwd=tcp::{{ .SSHHostPort }}-:22"],
    ["-device", "virtio-net,netdev=net1"]
  ]  
  ```
