{
  hostData,
  pkgs,
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

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.secrets."${hostData.zfsKeyFile}" = hostData.zfsKeyFile;

  fileSystems."/boot" = {
    device = "/dev/disk/by-partlabel/BOOT";
    fsType = "vfat";
    options = [
      "fmask=0177"
      "dmask=0077"
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

  system.stateVersion = "25.05";
}
