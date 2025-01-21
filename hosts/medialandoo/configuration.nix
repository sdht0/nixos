{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/option-python.nix

    ../../modules/system-nix-common.nix
    ../../modules/system-nix-linux.nix

    ../../modules/hardware-firmware.nix
    ../../modules/hardware-intel.nix
    ../../modules/hardware-ssd.nix
    ../../modules/hardware-lid-ignore.nix

    ../../modules/system-basic.nix
    ../../modules/system-users.nix
    ../../modules/system-audio.nix
    ../../modules/system-zfs.nix
    ../../modules/system-systemd-boot.nix
    ../../modules/system-initrd-systemd.nix
    ../../modules/system-watchdog-disable.nix

    ../../modules/networking-networkmanager.nix
    ../../modules/networking-mullvad.nix
    ../../modules/networking-sshd.nix
    ../../modules/networking-tailscale.nix
    ../../modules/networking-letsencrypt.nix

    ../../modules/pkgs-common.nix
    ../../modules/pkgs-docker.nix
    ../../modules/pkgs-syncthing.nix
    ../../modules/pkgs-xscripts.nix
  ];

  environment.systemPackages = with pkgs; [
    rclone
    getmail6
  ];
}
