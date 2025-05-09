#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y emacs emacsclient vim

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket

### Add NordVPN
rpm -v --import "https://repo.nordvpn.com/gpg/nordvpn_public.asc"
dnf5 config-manager addrepo --id="nordvpn" --set=baseurl="https://repo.nordvpn.com/yum/nordvpn/centos/$(uname -m)" --set=enabled=1 --overwrite
dnf5 install -y nordvpn
