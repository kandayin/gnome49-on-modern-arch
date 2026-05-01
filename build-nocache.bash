#!/usr/bin/env bash

podman build --no-cache . -t gnome49 -v /home/$USER/git/gnome49-on-modern-arch/output:/output > build.txt 2>&1
