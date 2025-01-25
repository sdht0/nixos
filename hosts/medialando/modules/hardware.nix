{
  config,
  lib,
  pkgs,
  ...
}:
let
  keyFile = "root.luks.bin";
in
{
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usbhid"
    "sdhci_pci"
  ];

  boot.initrd.luks.devices."root" = {
    device = "/dev/disk/by-partlabel/LUKS";
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
