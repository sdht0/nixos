{ config, lib, pkgs, modulesPath, ... }:

{
  networking.hostName = "niximaeus";
  nixpkgs.hostPlatform = "x86_64-linux";

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usbhid" "sdhci_pci" ];

  # Intel
  boot.kernelModules = [ "kvm-intel" ];
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
  hardware.opengl.extraPackages = with pkgs; [intel-media-driver];
  powerManagement.cpuFreqGovernor = "powersave";

  # Disable NVidia
  boot.initrd.kernelModules = [ "bbswitch" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ bbswitch ];
  boot.extraModprobeConfig = ''
    options bbswitch load_state=0 unload_state=0
  '';
  boot.blacklistedKernelModules = [ "nouveau" ];

  # Disk partitions
  boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/9efed530-afe0-4ef8-aee4-24910d168a34";
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/06b5ee16-a040-465d-9e58-df9bc6c7329c";
      fsType = "btrfs";
      options = [ "subvol=@nixos" "compress=zstd" ];
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
      options = [ "subvol=@home" "compress=zstd" ];
    };
  swapDevices = [ ];
}
