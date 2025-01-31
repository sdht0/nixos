{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../../../modules-lib/option-python.nix

    ../../../modules-lib/system-nix-common.nix
    ../../../modules-lib/system-nix-linux.nix

    ../../../modules-lib/hardware-firmware.nix
    ../../../modules-lib/hardware-intel.nix
    ../../../modules-lib/hardware-ssd.nix
    ../../../modules-lib/hardware-lid-ignore.nix

    ../../../modules-lib/system-basic.nix
    ../../../modules-lib/system-users.nix
    ../../../modules-lib/system-audio.nix
    ../../../modules-lib/system-zfs.nix
    ../../../modules-lib/system-systemd-boot.nix
    ../../../modules-lib/system-initrd-systemd.nix
    ../../../modules-lib/system-watchdog-disable.nix

    ../../../modules-lib/networking-networkmanager.nix
    ../../../modules-lib/networking-mullvad.nix
    ../../../modules-lib/networking-sshd.nix
    ../../../modules-lib/networking-tailscale.nix
    ../../../modules-lib/networking-letsencrypt.nix

    ../../../modules-lib/pkgs-common.nix
    ../../../modules-lib/pkgs-docker.nix
    ../../../modules-lib/pkgs-syncthing.nix
  ];

  environment.systemPackages = with pkgs; [
    rclone
    getmail6
  ];
}
