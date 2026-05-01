#!/usr/bin/env bash

podman build . -t gnome49 -v /home/$USER/git/gnome49-on-modern-arch/output:/output > build.txt 2>&1
