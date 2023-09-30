{ config, lib, pkgs, modulesPath, ... }:

{
  boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/579f8166-d13f-4128-abf7-a19d845bc82a";

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/6773e347-eee3-4078-980d-542ef28b9c4e";
      fsType = "btrfs";
      options = [ "subvol=@nixos" "compress=zstd" "noatime" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/6773e347-eee3-4078-980d-542ef28b9c4e";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress=zstd" "noatime" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/D935-10CE";
      fsType = "vfat";
    };

  swapDevices = [ ];
}
