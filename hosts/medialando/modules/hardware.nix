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
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "usbhid"
    "uas"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  boot.zfs.forceImportRoot = true;

  fileSystems."/" = {
    device = "zroot/nixos";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };
  fileSystems."/home" = {
    device = "zroot/home";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };
  swapDevices = [ ];

  system.stateVersion = "24.05";
}
