{ config, lib, pkgs, ... }:

{
  boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/9efed530-afe0-4ef8-aee4-24910d168a34";

  # Allow systemd automount
  # fileSystems."/boot" =
  #   { device = "/dev/disk/by-uuid/57D4-A2B2";
  #     fsType = "vfat";
  #   };
  # fileSystems."/efi" =
  #   { device = "/dev/disk/by-uuid/3280-5418";
  #     fsType = "vfat";
  #   };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/06b5ee16-a040-465d-9e58-df9bc6c7329c";
      fsType = "btrfs";
      options = [ "subvol=@nixos" "compress=zstd" "noatime" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/06b5ee16-a040-465d-9e58-df9bc6c7329c";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress=zstd" "noatime" ];
    };

  swapDevices = [ ];
}
