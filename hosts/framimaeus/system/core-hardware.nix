{
  hostData,
  pkgs,
  ...
}:
{
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "usbhid"
    "uas"
    "sd_mod"
  ];
  boot.kernelParams = [
    # 1. Disable IOMMU translation for performance/stability with large memory maps
    "iommu=pt"
    
    # 2. amdgpu settings (values are in MB)
    "amdgpu.gttsize=100000"
    
    # 3. TTM settings (values are number of pages)
    # 31457280 pages * 4KB/page = ~120GB
    "ttm.pages_limit=26214400"
    "ttm.page_pool_size=15728640"
  ];
  boot.initrd.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  boot.kernelPackages = pkgs.linuxPackages_6_18;
  boot.zfs.package = pkgs.zfs_2_4;

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
