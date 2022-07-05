#!/usr/bin/env fish

in_container_msg -h; or return

set root (status dirname)
set tag (basename $root)

rm -fr $root/images

podman build \
    -t $tag \
    $root/docker/; or return

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
