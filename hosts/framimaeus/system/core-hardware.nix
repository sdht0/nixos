{
  config,
  lib,
  pkgs,
  hostData,
  ...
}:
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

  boot.initrd.secrets."${hostData.zfsKeyFile}" = hostData.zfsKeyFile;
  systemd.tmpfiles.rules = [
    "d ${hostData.zfsKeyDir} 0700 root root -"
    "f ${hostData.zfsKeyFile} 0400 root root -"
  ];

  ### Commented out to allow systemd automount ###
  # fileSystems."/boot" = {
  #   device = "/dev/disk/by-label/BOOT";
  #   fsType = "vfat";
  #   options = [
  #     "fmask=0022"
  #     "dmask=0022"
  #   ];
  # };
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
