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
    ../../../modules-lib/system-nix-ld.nix

    ../../../modules-lib/hardware-firmware.nix
    ../../../modules-lib/hardware-fwupd.nix
    ../../../modules-lib/hardware-amd.nix
    ../../../modules-lib/hardware-ssd.nix
    ../../../modules-lib/hardware-logitech.nix
    ../../../modules-lib/hardware-canon-ts3420.nix

    ../../../modules-lib/system-basic-linux.nix
    ../../../modules-lib/system-basic-linux-sysctl.nix
    ../../../modules-lib/system-initrd-systemd.nix
    ../../../modules-lib/system-plasma6.nix
    ../../../modules-lib/system-audio.nix
    ../../../modules-lib/system-bluetooth.nix
    ../../../modules-lib/system-oom.nix
    ../../../modules-lib/system-systemd-boot.nix
    ../../../modules-lib/system-users.nix
    ../../../modules-lib/system-watchdog-disable.nix
    ../../../modules-lib/system-zfs.nix

    ../../../modules-lib/networking-networkmanager.nix
    ../../../modules-lib/networking-tailscale.nix
    # ../../../modules-lib/networking-mullvad.nix

    ../../../modules-lib/pkgs-common-linux.nix
    ../../../modules-lib/pkgs-podman.nix
    ../../../modules-lib/pkgs-syncthing.nix
    ../../../modules-lib/pkgs-sshagent.nix
    ../../../modules-lib/pkgs-fonts.nix
    ../../../modules-lib/pkgs-dev-nix.nix
    ../../../modules-lib/pkgs-debuginfod.nix
    ../../../modules-lib/pkgs-dev-python.nix
  ];
}
