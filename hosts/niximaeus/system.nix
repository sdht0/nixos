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
    ./packages.nix
    ./custom-systemd-boot.nix
  ];

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.systemd-boot.xbootMountPoint = "/boot";
  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usbhid" "sdhci_pci" ];
  boot.kernelParams = [ "quiet" "nowatchdog" ];

  # Disk partitions
  boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/9efed530-afe0-4ef8-aee4-24910d168a34";
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/06b5ee16-a040-465d-9e58-df9bc6c7329c";
      fsType = "btrfs";
      options = [ "subvol=@nixos" "compress=zstd" "noatime" ];
    };
  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/57D4-A2B2";
      fsType = "vfat";
    };
  fileSystems."/efi" =
    { device = "/dev/disk/by-uuid/3280-5418";
      fsType = "vfat";
    };
  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/06b5ee16-a040-465d-9e58-df9bc6c7329c";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress=zstd" "noatime" ];
    };
  swapDevices = [ ];

  system.stateVersion = "23.05";
}
