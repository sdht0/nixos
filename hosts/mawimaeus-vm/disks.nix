let
  config = import ./host-data.nix;
in
{
  disko.devices = {
    disk = {
      zfsdisk = {
        type = "disk";
        device = config.disk;
        content = {
          type = "gpt";
          partitions = {
            BOOT = {
              size = "1G";
              type = "EF00";
              label = "BOOT";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
                extraArgs = ["-n" "BOOT"];
              };
            };
            ZFS = {
              size = "100%";
              type = "8300";
              label = "ZFS";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        rootFsOptions = {
          mountpoint = "none";
          canmount = "off";
          devices = "off";
          compression = "zstd";
          acltype = "posixacl";
          xattr = "sa";
          dnodesize = "auto";
          encryption = "aes-256-gcm";
          keyformat = "passphrase";
          keylocation = "file://${config.zfsKeyFile}";
          atime = "off";
        };
        options.ashift = "12";
        datasets = {
          "nixos" = {
            type = "zfs_fs";
            options.mountpoint = "/";
            mountpoint = "/";
          };
          "home" = {
            type = "zfs_fs";
            options.mountpoint = "/home";
            mountpoint = "/home";
          };
        };
      };
    };
  };
}
