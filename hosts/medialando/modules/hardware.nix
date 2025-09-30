{
  config,
  lib,
  pkgs,
  ...
}:
let
  keyFile = "/var/lib/secrets/zroot.key";
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

  boot.initrd.secrets."/root/zroot.key" = keyFile;
  systemd.tmpfiles.rules = [
    "f ${keyFile} 0400 root root -"
  ];

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
