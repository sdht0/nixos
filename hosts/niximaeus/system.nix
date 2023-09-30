{ config, pkgs, ... }:

{
  imports = [
    ../../configs/hardware/intel.nix
    ../../configs/hardware/nvidia.nix
    ../../configs/hardware/ssd.nix
    ../../configs/hardware/logitech.nix
    ../../configs/hardware/fingerprintreader.nix

    ../../configs/system/common.nix
    ../../configs/system/plasma5.nix

    ./partitions.nix
    ./packages.nix

    ../../configs/system/systemd-boot/custom-systemd-boot.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 25;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.systemd-boot.xbootMountPoint = "/boot";

  boot.initrd.systemd.enable = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usbhid" "sdhci_pci" ];
  boot.kernelParams = [ "quiet" ];
  boot.blacklistedKernelModules = [ "iTCO_wdt" "iTCO_vendor_support" ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.stateVersion = "23.05";
}
