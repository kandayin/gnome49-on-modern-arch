from archlinux

run pacman -Sy --noconfirm archlinux-keyring
run pacman-key --init
run pacman -Syu --noconfirm

run pacman -S --noconfirm --needed base-devel git cargo devtools cmake

run useradd -m localuser
run echo "localuser ALL=NOPASSWD: ALL" > /etc/sudoers.d/localuser
user localuser

# various things builds need
run mkdir -p ~/.gnupg
run echo "keyserver-options auto-key-retrieve" >> ~/.gnupg/gpg.conf

run sudo sh -c 'printf "C.UTF-8 UTF-8\nen_CA.UTF-8 UTF-8\nen_US.UTF-8 UTF-8\n" > /etc/locale.gen'
run sudo locale-gen --purge C.UTF-8 en_CA.UTF-8 en_US.UTF-8

run sudo sh -c "echo 1j90rjffnu9wfej012j812e1r2nm08j8 > /etc/machine-id"

# xterm-256color fixes some tests in malcontent which expect emojis 
env TERM xterm-256color

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https accountsservice
workdir /home/localuser/pkgctl/accountsservice
run makepkg -sif --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https malcontent
workdir /home/localuser/pkgctl/malcontent
run makepkg -sif --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https tecla
workdir /home/localuser/pkgctl/tecla
run git checkout 49.0-1
run sed -i 's/local meson_options=(/local meson_options=( -D x11=true/' PKGBUILD
run makepkg -sif --noconfirm
run mv *.zst /output/

run mkdir -p /home/localuser/pkgctl
workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https gnome-text-editor
workdir /home/localuser/pkgctl/gnome-text-editor
run git checkout 49.1-1
run makepkg -sif --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https mutter
workdir /home/localuser/pkgctl/mutter
run git checkout 49.5-1
run sed -i 's/local meson_options=(/local meson_options=( -D x11=true/' PKGBUILD
run makepkg -sif --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https gnome-session
workdir /home/localuser/pkgctl/gnome-session
run git checkout 49.2-1
run sed -i 's/local meson_options=(/local meson_options=( -D x11=true/' PKGBUILD
run makepkg -sif --noconfirm
run mv *.zst /output/

env PKG_CONFIG_PATH /usr/lib/pkgconfig:/usr/share/pkgconfig

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https gnome-shell
workdir /home/localuser/pkgctl/gnome-shell
run git checkout 1-49.5-1
run makepkg -sif --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https gdm
workdir /home/localuser/pkgctl/gdm
run git checkout 49.2-1
run sed -i 's/local meson_options=(/local meson_options=( -D x11-support=true/' PKGBUILD
run makepkg -sif --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https gnome-remote-desktop
workdir /home/localuser/pkgctl/gnome-remote-desktop
run git checkout 49.3-1
run makepkg -sif --noconfirm
run mv *.zst /output/

workdir /home/localuser/pkgctl
run pkgctl repo clone --protocol=https gnome-control-center
workdir /home/localuser/pkgctl/gnome-control-center
run git checkout 49.6-1
run sed -i 's/local meson_options=(/local meson_options=( -D x11=true/' PKGBUILD
run makepkg -sif --noconfirm
run mv *.zst /output/
