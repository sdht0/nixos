{ config, pkgs, ... }:

{
  imports = [
    ../../configs/system/common.nix

    ../../configs/system/intel.nix
    ../../configs/system/ssd.nix
    ../../configs/system/zfs.nix

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
  boot.blacklistedKernelModules = [ "iTCO_wdt" "iTCO_vendor_support" ]; # Disable watchdog

  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  services.logind.lidSwitch = "ignore";

  system.stateVersion = "23.05";
}
