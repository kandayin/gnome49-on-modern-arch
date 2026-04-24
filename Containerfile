from archlinux

run pacman -Sy --noconfirm --needed archlinux-keyring base-devel git cargo devtools
run pacman-key --init

# ensure that we don't install pre-built versions of the packages we build
run sed -i 's/#IgnorePkg   =/IgnorePkg = adwaita-cursors adwaita-fonts adwaita-icon-theme epiphany gdm gnome-backgrounds gnome-calendar gnome-connections gnome-control-center gnome-font-viewer gnome-keybindings gnome-remote-desktop gnome-session gnome-settings-daemon gnome-shell gnome-shell-docs gnome-shell-extensions gnome-software gnome-system-monitor gnome-text-editor gnome-user-docs libgdm libnautilus-extension libnautilus-extension-docs mutter mutter-devkit mutter-docs nautilus tecla xdg-desktop-portal-gnome/' /etc/pacman.conf

run useradd -m localuser
run echo "localuser ALL=NOPASSWD: ALL" > /etc/sudoers.d/localuser
user localuser

# various things builds need
run mkdir -p ~/.gnupg
run echo "keyserver-options auto-key-retrieve" >> ~/.gnupg/gpg.conf

run sudo sh -c 'printf "C.UTF-8 UTF-8\nen_CA.UTF-8 UTF-8\nen_US.UTF-8 UTF-8\n" > /etc/locale.gen'
run sudo locale-gen --purge C.UTF-8 en_CA.UTF-8 en_US.UTF-8

run sudo sh -c "echo 1j90rjffnu9wfej012j812e1r2nm08j8 > /etc/machine-id"

# adwaita-cursors is also built via adwaita-icon-theme
workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https adwaita-icon-theme
workdir /home/localuser/pkgctl/adwaita-icon-theme
run git checkout 49.0-1
run makepkg -si --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https adwaita-fonts
workdir /home/localuser/pkgctl/adwaita-fonts
run git checkout 49.0-2
run makepkg -si --noconfirm
run mv *.zst /output/

# xterm-256color fixes some tests in malcontent which expect emojis 
env TERM xterm-256color

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https tecla
workdir /home/localuser/pkgctl/tecla
run git checkout 49.0-1
run sed -i 's/local meson_options=(/local meson_options=( -D x11=true/' PKGBUILD
run makepkg -si --noconfirm
run mv *.zst /output/

run mkdir -p /home/localuser/pkgctl
workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https gnome-text-editor
workdir /home/localuser/pkgctl/gnome-text-editor
run git checkout 49.1-1
run makepkg -si --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https mutter
workdir /home/localuser/pkgctl/mutter
run git checkout 49.5-1
run sed -i 's/local meson_options=(/local meson_options=( -D x11=true/' PKGBUILD
run makepkg -si --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https nautilus
workdir /home/localuser/pkgctl/nautilus
run git checkout 49.5-1
run makepkg -si --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https xdg-desktop-portal-gnome
workdir /home/localuser/pkgctl/xdg-desktop-portal-gnome
run git checkout 49.0-1
run sed -i 's/local meson_options=(/local meson_options=( -D x11=true/' PKGBUILD
run makepkg -si --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https gnome-session
workdir /home/localuser/pkgctl/gnome-session
run git checkout 49.2-1
run sed -i 's/local meson_options=(/local meson_options=( -D x11=true/' PKGBUILD
run makepkg -si --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https gnome-remote-desktop
workdir /home/localuser/pkgctl/gnome-remote-desktop
run git checkout 49.3-1
run makepkg -si --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https gnome-shell
workdir /home/localuser/pkgctl/gnome-shell
run git checkout 1-49.5-1
run makepkg -si --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https gnome-control-center
workdir /home/localuser/pkgctl/gnome-control-center
run git checkout 49.6-1
run sed -i 's/local meson_options=(/local meson_options=( -D x11=true/' PKGBUILD
run makepkg -si --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https gdm
workdir /home/localuser/pkgctl/gdm
run git checkout 49.2-1
run sed -i 's/local meson_options=(/local meson_options=( -D x11-support=true/' PKGBUILD
run makepkg -si --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https gnome-user-docs
workdir /home/localuser/pkgctl/gnome-user-docs
run git checkout 49.4-1
run sed -i 's/local meson_options=(/local meson_options=( -D x11=true/' PKGBUILD
run makepkg -si --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https gnome-settings-daemon
workdir /home/localuser/pkgctl/gnome-settings-daemon
run git checkout 49.1-1
run sed -i 's/local meson_options=(/local meson_options=( -D x11=true/' PKGBUILD
# --nocheck because these tests don't work well in a container
run makepkg --nocheck -sif --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https gnome-shell-extensions
workdir /home/localuser/pkgctl/gnome-shell-extensions
run git checkout 49.0-1
run sed -i 's/local meson_options=(/local meson_options=( -D x11=true/' PKGBUILD
run makepkg -si --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https gnome-software
workdir /home/localuser/pkgctl/gnome-software
run git checkout 49.3-1
run makepkg -si --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https gnome-system-monitor
workdir /home/localuser/pkgctl/gnome-system-monitor
run git checkout 49.1-1
run sed -i 's/local meson_options=(/local meson_options=( -D x11=true/' PKGBUILD
run makepkg -si --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https gnome-connections
workdir /home/localuser/pkgctl/gnome-connections
run git checkout 49.0-1
run sed -i 's/local meson_options=(/local meson_options=( -D x11=true/' PKGBUILD
run makepkg -si --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https gnome-font-viewer
workdir /home/localuser/pkgctl/gnome-font-viewer
run git checkout 49.0-1
run sed -i 's/local meson_options=(/local meson_options=( -D x11=true/' PKGBUILD
run makepkg -si --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https gnome-backgrounds
workdir /home/localuser/pkgctl/gnome-backgrounds
run git checkout 49.0-1
run sed -i 's/local meson_options=(/local meson_options=( -D x11=true/' PKGBUILD
run makepkg -si --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https gnome-calendar
workdir /home/localuser/pkgctl/gnome-calendar
run git checkout 49.1-1
run sed -i 's/local meson_options=(/local meson_options=( -D x11=true/' PKGBUILD
run makepkg -si --noconfirm
run mv *.zst /output/
