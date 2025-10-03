{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "uhci_hcd"
    "virtio_pci"
    "usbhid"
    "usb_storage"
    "sr_mod"
  ];

  ### Commented out to allow systemd automount ###
  # fileSystems."/boot" =
  #   { device = "/dev/disk/by-label/BOOT";
  #     fsType = "vfat";
  #     options = [ "fmask=0022" "dmask=0022" ];
  #   };
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
