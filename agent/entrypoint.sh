#!/bin/sh
mount --make-rshared /
systemctl restart autofs

k3s agent --prefer-bundled-bin 
