/usr/bin/qemu-system-x86_64 -netdev user,id=user.0 -drive file=output_rhel_test/vmtest,if=virtio,cache=writeback,discard=ignore,format=qcow2 -drive file=/root/packer101/rhel/rhel-8.6-x86_64-dvd.iso,media=cdrom -boot once=d -display gtk -name vmtest -m 1024M -device virtio-net,netdev=user.0 -machine "type=q35,accel=kvm"


