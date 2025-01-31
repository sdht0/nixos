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
    ../../../module-lib/hardware-ssd.nix
    ../../../module-lib/hardware-lid-ignore.nix

    ../../../module-lib/system-basic.nix
    ../../../module-lib/system-users.nix
    ../../../module-lib/system-audio.nix
    ../../../module-lib/system-zfs.nix
    ../../../module-lib/system-systemd-boot.nix
    ../../../module-lib/system-initrd-systemd.nix
    ../../../module-lib/system-watchdog-disable.nix

    ../../../module-lib/networking-networkmanager.nix
    ../../../module-lib/networking-mullvad.nix
    ../../../module-lib/networking-sshd.nix
    ../../../module-lib/networking-tailscale.nix
    ../../../module-lib/networking-letsencrypt.nix

    ../../../module-lib/pkgs-common.nix
    ../../../module-lib/pkgs-docker.nix
    ../../../module-lib/pkgs-syncthing.nix
    ../../../module-lib/pkgs-xscripts.nix
  ];

  environment.systemPackages = with pkgs; [
    rclone
    getmail6
  ];
}
