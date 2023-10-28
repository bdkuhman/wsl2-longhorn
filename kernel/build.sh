#!/bin/bash

LAYER=$(docker build . 2>&1 | grep "^Successfully built" | cut -d" " -f3)
CONTAINER=$(docker create $LAYER)
docker cp $CONTAINER:src/arch/x86/boot/bzImage ./$1
docker rm $CONTAINER > /dev/null