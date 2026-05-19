#!/usr/bin/env fish

__in_container_msg -h
or return

set root (status dirname | path resolve)
set tag (path basename $root)

rm -fr $root/images

podman build \
    -t $tag \
    $root/docker/
or return

podman run \
    --env BUS_SPEED=800 \
    --env CLEAN=1 \
    --env DDR_SPEED=3200 \
    --env SOC_SPEED=2200 \
    --interactive \
    --rm \
    --tty \
    --volume $root:/work:Z \
    $tag build
