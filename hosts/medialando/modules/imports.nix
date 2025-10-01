{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../../../modules-lib/option-python.nix

    ../../../modules-lib/system-nix-linux.nix

    ../../../modules-lib/hardware-firmware.nix
    ../../../modules-lib/hardware-fwupd.nix
    ../../../modules-lib/hardware-intel.nix
    ../../../modules-lib/hardware-nvidia-disable.nix
    ../../../modules-lib/hardware-ssd.nix
    ../../../modules-lib/hardware-lid-ignore.nix

    ../../../modules-lib/system-basic-linux-sysctl.nix
    ../../../modules-lib/system-basic-linux.nix
    ../../../modules-lib/system-btrfs-home-snapshots.nix
    ../../../modules-lib/system-initrd-systemd.nix
    ../../../modules-lib/system-oom.nix
    ../../../modules-lib/system-systemd-boot.nix
    ../../../modules-lib/system-systemd-boot-xbootldr.nix
    ../../../modules-lib/system-users.nix
    ../../../modules-lib/system-watchdog-disable.nix
    ../../../modules-lib/system-zfs.nix

    ../../../modules-lib/networking-networkmanager.nix
    ../../../modules-lib/networking-mullvad.nix
    ../../../modules-lib/networking-sshd.nix
    ../../../modules-lib/networking-tailscale.nix
    ../../../modules-lib/networking-letsencrypt.nix

    ../../../modules-lib/pkgs-common-linux.nix
    ../../../modules-lib/pkgs-docker.nix
    ../../../modules-lib/pkgs-syncthing.nix

    # ../../../modules-lib/hardware-fingerprintreader.nix
    # ../../../modules-lib/hardware-canon-ts3420.nix
    # ../../../modules-lib/hardware-logitech.nix
    # ../../../modules-lib/system-bluetooth.nix
    # ../../../modules-lib/system-users-autologin.nix
    # ../../../modules-lib/system-audio.nix
    # ../../../modules-lib/pkgs-sshagent.nix
    # ../../../modules-lib/pkgs-fonts.nix
    # ../../../modules-lib/pkgs-latex.nix
    # ../../../modules-lib/pkgs-nixdev.nix
    # ../../../modules-lib/pkgs-debuginfod.nix
    #../../../modules-lib/system-plymouth.nix
    #../../../modules-lib/system-plasma6.nix
  ];
}
