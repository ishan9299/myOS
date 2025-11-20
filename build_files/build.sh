#!/bin/bash

set -ouex pipefail

### Install packages

dnf5 install -y meson ninja-build cmake gcc make gettext curl glibc-gconv-extra git clang python stow lua --setopt=install_weak_deps=False

scroll_packages=(
	"wayland-devel"
	"mesa-libEGL-devel"
	"mesa-libGLES-devel"
	"mesa-dri-drivers"
	"xorg-x11-server-Xwayland"
	"libdrm-devel"
	"libgbm-devel"
	"libxkbcommon-devel"
	"libudev-devel"
	"pixman-devel"
	"libinput-devel"
	"libevdev-devel"
	"systemd-devel"
	"cairo-devel"
	"libpcap-devel"
	"json-c-devel"
	"pam-devel"
	"pango-devel"
	"pcre-devel"
	"gdk-pixbuf2-devel"
	"hwdata-devel"
	"wayland-protocols-devel"
	"mesa-libEGL-devel"
	"mesa-libGLES-devel"
	"vulkan-loader-devel"
	"vulkan-headers"
	"mesa-libgbm-devel"
	"systemd-devel"
	"pixman-devel"
	"libseat-devel"
	"hwdata"
	"libdisplay-info-devel"
	"libliftoff-devel"
	"glslang"
	"lua-devel"
)

dnf5 install -y "${scroll_packages[@]}"
cd /tmp
git clone --depth=1 https://github.com/dawsers/scroll
cd scroll
meson setup build/
ninja -C build/
cp build/sway/scroll /usr/bin/scroll
cp build/swaymsg/scrollmsg /usr/bin/scrollmsg
cp build/swaybar/scrollbar /usr/bin/scrollbar
cp build/swaynag/scrollnag /usr/bin/scrollnag
mkdir -p /etc/scroll/ && cp build/config /etc/scroll/config
cp scroll.desktop /usr/share/wayland-sessions/scroll.desktop
cp completions/bash/scroll /usr/share/bash-completion/completions/scroll
cp completions/bash/scrollmsg /usr/share/bash-completion/completions/scrollmsg
cp completions/bash/scrollbar /usr/share/bash-completion/completions/scrollbar
cd ..
rm -rf scroll

dnf5 install -y qemu libvirt steam-devices sddm tmux kitty wmenu-run mesa-dri-drivers polkit swaybg xorg-x11-server-Xwayland grim

# dnf5 copr -y enable scrollwm/packages
# dnf5 install -y scroll

#### Example for enabling a System Unit File
systemctl enable sddm
systemctl enable libvirtd
systemctl enable podman.socket
