{
  config,
  lib,
  ...
}:
let
  keyFile = "root.luks.bin";
in
{

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "usb_storage"
    "sd_mod"
  ];

  services.logind.lidSwitch = "ignore";

  boot.initrd.luks.devices."root" = {
    device = "/dev/disk/by-uuid/579f8166-d13f-4128-abf7-a19d845bc82a";
    keyFile = "/${keyFile}";
  };
  boot.initrd.secrets = {
    "/${keyFile}" = /var/lib/secrets/${keyFile};
  };
  ### Commented out to allow systemd automount ###
  # fileSystems."/boot" =
  #   { device = "/dev/disk/by-uuid/D935-10CE";
  #     fsType = "vfat";
  #   };
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/6773e347-eee3-4078-980d-542ef28b9c4e";
    fsType = "btrfs";
    options = [
      "subvol=@nixos"
      "compress=zstd"
      "noatime"
    ];
  };
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/6773e347-eee3-4078-980d-542ef28b9c4e";
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
