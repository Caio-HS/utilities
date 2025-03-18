#!/bin/bash

set -e

mkdir -p ~/ramdisk

sudo mount -t tmpfs -o size=$1 tmpfs ~/ramdisk

read -n 1 -s -r -p "Your directory has been created, you can now use it.
Press any key to delete it.
"

sudo umount ~/ramdisk

rmdir ~/ramdisk

echo ""
exit 0
