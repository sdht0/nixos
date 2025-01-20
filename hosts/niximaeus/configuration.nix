{
  config,
  lib,
  pkgs,
  hostData,
  inputs,
  ...
}:
let
  keyFile = "root.luks.bin";
in
{
  imports = [
    ../../modules/option-python.nix

    ../../modules/system-nix-common.nix
    ../../modules/system-nix-linux.nix

    ../../modules/hardware-firmware.nix
    ../../modules/hardware-intel.nix
    ../../modules/hardware-ssd.nix

    ../../modules/system-btrfs-home-snapshots.nix
    ../../modules/system-plasma6.nix
    #../../modules/system-plymouth.nix

    ../../modules/system-basic.nix
    ../../modules/system-users.nix
    ../../modules/system-audio.nix
    ../../modules/system-zfs.nix
    ../../modules/system-systemd-boot.nix
    ../../modules/system-systemd-boot-xbootldr.nix
    ../../modules/system-initrd-systemd.nix
    ../../modules/system-watchdog-disable.nix
    ../../modules/system-oom.nix

    ../../modules/networking-networkmanager.nix
    ../../modules/networking-mullvad.nix
    ../../modules/networking-sshd.nix
    ../../modules/networking-tailscale.nix
    ../../modules/networking-letsencrypt.nix

    ../../modules/pkgs-common.nix
    ../../modules/pkgs-docker.nix
    ../../modules/pkgs-syncthing.nix
    ../../modules/pkgs-xscripts.nix

    ../../modules/hardware-nvidia-disable.nix
    # ../../modules/hardware-fingerprintreader.nix
    # ../../modules/hardware-canon-ts3420.nix
    # ../../modules/hardware-logitech.nix
    # ../../modules/system-bluetooth.nix
    # ../../modules/system-users-autologin.nix
    # ../../modules/pkgs-sshagent.nix
    # ../../modules/pkgs-fonts.nix
    # ../../modules/pkgs-latex.nix
    # ../../modules/pkgs-nixdev.nix
    # ../../modules/pkgs-debuginfod.nix
  ];

  environment.systemPackages = with pkgs; [
    rclone
    getmail6
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usbhid"
    "sdhci_pci"
  ];

  services.logind.lidSwitch = "ignore";

  boot.initrd.luks.devices."root" = {
    device = "/dev/disk/by-uuid/9efed530-afe0-4ef8-aee4-24910d168a34";
    keyFile = "/${keyFile}";
  };
  boot.initrd.secrets = {
    "/${keyFile}" = /var/lib/secrets/${keyFile};
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/LINUX";
    fsType = "btrfs";
    options = [
      "subvol=@nixos"
      "compress=zstd"
      "noatime"
    ];
  };
  fileSystems."/home" = {
    device = "/dev/disk/by-label/LINUX";
    fsType = "btrfs";
    options = [
      "subvol=@home"
      "compress=zstd"
      "noatime"
    ];
  };
  swapDevices = [ ];

  system.stateVersion = "23.05";
}
