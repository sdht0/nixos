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
    ../../modules/hardware-nvidia-disable.nix
    ../../modules/hardware-ssd.nix
    ../../modules/hardware-lid-ignore.nix

    ../../modules/system-basic.nix
    ../../modules/system-users.nix
    ../../modules/system-zfs.nix
    ../../modules/system-systemd-boot.nix
    ../../modules/system-systemd-boot-xbootldr.nix
    ../../modules/system-initrd-systemd.nix
    ../../modules/system-watchdog-disable.nix
    ../../modules/system-oom.nix
    ../../modules/system-btrfs-home-snapshots.nix

    ../../modules/networking-networkmanager.nix
    ../../modules/networking-mullvad.nix
    ../../modules/networking-sshd.nix
    ../../modules/networking-tailscale.nix
    ../../modules/networking-letsencrypt.nix

    ../../modules/pkgs-common.nix
    ../../modules/pkgs-docker.nix
    ../../modules/pkgs-syncthing.nix
    ../../modules/pkgs-xscripts.nix

    # ../../modules/hardware-fingerprintreader.nix
    # ../../modules/hardware-canon-ts3420.nix
    # ../../modules/hardware-logitech.nix
    # ../../modules/system-bluetooth.nix
    # ../../modules/system-users-autologin.nix
    # ../../modules/system-audio.nix
    # ../../modules/pkgs-sshagent.nix
    # ../../modules/pkgs-fonts.nix
    # ../../modules/pkgs-latex.nix
    # ../../modules/pkgs-nixdev.nix
    # ../../modules/pkgs-debuginfod.nix
    #../../modules/system-plymouth.nix
    #../../modules/system-plasma6.nix
  ];

  environment.systemPackages = with pkgs; [
    rclone
    isync
  ];
}
