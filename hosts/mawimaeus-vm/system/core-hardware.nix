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

  boot.kernelPackages = pkgs.linuxPackages_6_18;

  services.fwupd.enable = false;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/ecca5e94-c285-46c6-a4d3-f81dca0f0fd1";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/5CB0-FF40";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ ];

  system.stateVersion = "25.05";
}
