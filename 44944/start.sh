#!/bin/sh
cd /home/root/44944
chmod -R 755 *
./libs/ld-linux-aarch64.so.1 --library-path ./libs ./server &

