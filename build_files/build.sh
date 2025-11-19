#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

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
# cp build/config
# ninja -C build/ install
cd ..
rm -rf scroll
dnf5 remove -y "${scroll_packages[@]}"

dnf5 -y group install virtualization
dnf5 install -y steam-devices

dnf5 install -y tmux kitty wmenu-run
dnf5 install -y sddm hyprcursor mako pipewire wireplumber \
	xdg-desktop-portal-hyprland waybar nautilus network-manager-applet \
	gvfs gvfs-afc gvfs-afp gvfs-archive gvfs-client gvfs-fuse gvfs-goa gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb


# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable sddm
systemctl enable libvirtd
systemctl enable podman.socket
