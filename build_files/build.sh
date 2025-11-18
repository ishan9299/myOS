#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux
dnf5 install -y ninja-build cmake gcc make gettext curl glibc-gconv-extra git clang python stow
dnf5 -y copr enable solopasha/hyprland
dnf5 install -y sddm hyprland hyprpolkitagent hyprcursor mako pipewire wireplumber xdg-desktop-portal-hyprland waybar nautilus udiskie iwgtk \
	gvfs gvfs-afc gvfs-afp gvfs-archive gvfs-client gvfs-fuse gvfs-goa gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb
dnf5 -y group install virtualization
dnf5 install -y steam-devices

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

dnf5 -y copr disable solopasha/hyprland

#### Example for enabling a System Unit File

systemctl enable sddm
systemctl enable libvirtd
systemctl enable podman.socket
