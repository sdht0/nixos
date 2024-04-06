{ config, lib, pkgs, ... }:

{
  imports = [
    ../../configs/system/common.nix
    ../../configs/system/intel.nix
    ../../configs/system/ssd.nix
    ../../configs/system/zfs.nix

    ../../configs/packages/systemd-boot.nix
    ../../configs/packages/common.nix
    ../../configs/packages/letsencrypt.nix
    ../../configs/packages/sshd.nix
    ../../configs/packages/syncthing.nix

    ./partitions.nix
  ];

  boot.loader.efi.efiSysMountPoint = "/boot";

  boot.initrd.systemd.enable = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.kernelParams = [ "quiet" ];
  boot.blacklistedKernelModules = [ "iTCO_wdt" "iTCO_vendor_support" ]; # Disable watchdog

  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  services.logind.lidSwitch = "ignore";

  environment.systemPackages = with pkgs; [
    chromium yt-dlp-git nodejs (pkgs.python3.withPackages (ps: with ps; [ pip beautifulsoup4 dateutil lxml ])) # download.sh
  ];
  programs.npm.enable = true;
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    autoPrune.dates = "daily";
  };

  system.stateVersion = "23.05";
}
