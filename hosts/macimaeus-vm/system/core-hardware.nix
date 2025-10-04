{
  config,
  lib,
  pkgs,
  hostData,
  ...
}:
{
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "uhci_hcd"
    "virtio_pci"
    "usbhid"
    "usb_storage"
    "sr_mod"
  ];

  boot.initrd.secrets."${hostData.zfsKeyFile}" = hostData.zfsKeyFile;

  fileSystems."/boot" = {
    device = "/dev/disk/by-partlabel/BOOT";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };
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
