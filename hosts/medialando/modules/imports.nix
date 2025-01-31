{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../../../module-lib/option-python.nix

    ../../../module-lib/system-nix-common.nix
    ../../../module-lib/system-nix-linux.nix

    ../../../module-lib/hardware-firmware.nix
    ../../../module-lib/hardware-intel.nix
    ../../../module-lib/hardware-nvidia-disable.nix
    ../../../module-lib/hardware-ssd.nix
    ../../../module-lib/hardware-lid-ignore.nix

    ../../../module-lib/system-basic.nix
    ../../../module-lib/system-users.nix
    ../../../module-lib/system-zfs.nix
    ../../../module-lib/system-systemd-boot.nix
    ../../../module-lib/system-systemd-boot-xbootldr.nix
    ../../../module-lib/system-initrd-systemd.nix
    ../../../module-lib/system-watchdog-disable.nix
    ../../../module-lib/system-oom.nix
    ../../../module-lib/system-btrfs-home-snapshots.nix

    ../../../module-lib/networking-networkmanager.nix
    ../../../module-lib/networking-mullvad.nix
    ../../../module-lib/networking-sshd.nix
    ../../../module-lib/networking-tailscale.nix
    ../../../module-lib/networking-letsencrypt.nix

    ../../../module-lib/pkgs-common.nix
    ../../../module-lib/pkgs-docker.nix
    ../../../module-lib/pkgs-syncthing.nix

    # ../../../module-lib/hardware-fingerprintreader.nix
    # ../../../module-lib/hardware-canon-ts3420.nix
    # ../../../module-lib/hardware-logitech.nix
    # ../../../module-lib/system-bluetooth.nix
    # ../../../module-lib/system-users-autologin.nix
    # ../../../module-lib/system-audio.nix
    # ../../../module-lib/pkgs-sshagent.nix
    # ../../../module-lib/pkgs-fonts.nix
    # ../../../module-lib/pkgs-latex.nix
    # ../../../module-lib/pkgs-nixdev.nix
    # ../../../module-lib/pkgs-debuginfod.nix
    #../../../module-lib/system-plymouth.nix
    #../../../module-lib/system-plasma6.nix
  ];
}
