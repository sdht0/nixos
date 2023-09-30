{ config, pkgs, ... }:

{
  imports = [
    ../../configs/hardware/intel.nix
    ../../configs/hardware/ssd.nix

    ../../configs/system/common.nix

    ./partitions.nix
    ./packages.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 25;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  boot.initrd.systemd.enable = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.kernelParams = [ "quiet" ];

  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  networking.hostId = "3eb4f87f";

  services.sanoid.enable = true;
  services.sanoid.interval = "daily";
  services.sanoid.datasets.medialand = {
    recursive = "zfs";
    processChildrenOnly = true;
    autoprune = true;
    autosnap = true;
    daily = 7;
    monthly = 5;
  };

  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  services.logind.lidSwitch = "ignore";

  system.stateVersion = "23.05";
}
