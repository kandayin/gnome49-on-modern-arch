# Gnome 49 on Modern Arch Linux

## Note
This is a work-in-progress.  It is not yet complete.  That said, it is working on my machine on 2026-04-20.

## Background

Gnome 50 dropped support for X11.  Some of us want to keep using X11 on Arch with Gnome.  Since Arch is a rolling release, there's no way to keep your system secure via updates AND run Gnome + X11 anymore.  This repo attempts to bridge that by downgrading Gnome to version 49 while building against modern updated packages.

## How to

1. Set up some kind of container build tool.  We'll use `podman` in our examples.
1. Clone this repo.
1. Open a terminal and `cd` to where you cloned the repo.
1. `podman build -v /some/local/path/for/output:/output . -t gnome49`
1. Now install the resulting packages: `cd output && sudo pacman -U $(ls | grep zst | grep -v debug)`

**NOTE**: You will need to re-run the last step every time you `pacman -Suy` your system, because it will upgrade them again.  But this will get you an up-to-date system with Gnome 49.
