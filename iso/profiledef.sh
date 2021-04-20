#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="GenOS"
iso_label="genos_$(date +%Y%m)"
iso_publisher="Ege BALCI <http://www.github.com/egebalci>"
iso_application="My Linux distribution, based on Arch Linux."
iso_version="$(date +%Y.%m.%d)"
install_dir="arch"
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito' 'uefi-x64.systemd-boot.esp' 'uefi-x64.systemd-boot.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
