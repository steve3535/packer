### How does ssh work in packer ?
* Once you start a packer session, at the very beginning, it will spark a ssh agent via its builtin ssh communicator mechanism, that ssh agent is forwarding the "future" vm instance ssh port to localhost on a certain port that is even displayed at the very begining of the session
* With qemu provisionner, when using a usermode networking, the host it self doesnt have access to the network, which is inside qemu and hence isolated from the host, hence the necessity of ssh port forwarding
* sometimes, it happened that i have to use qemuargs to explicitly set the port forwarding but according to packer docs, this shouldnt be required: packer handles it
* something i noticed however is that sometimes the ssh connection prior toexecuting the provisionners, fails. It times out. the only solution seems to increase the timeout delay ...
  * to workaround the delay, we can use the accelerator = kvm for qemu provisionner, but be aware: this needs the user running the process to be part of the kvm group
